{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "wangyizun";
in
{
  home = {
    username = "${user}";
    homeDirectory = "/nas/${user}";
    packages = pkgs.callPackage ./packages.nix { };
    stateVersion = "25.05";
  };

  systemd.user.services.atuin-daemon = {
    Unit = {
      Description = "Atuin daemon";
      Requires = [ "atuin-daemon.socket" ];
    };
    Install = {
      Also = [ "atuin-daemon.socket" ];
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe config.home.packages.atuin.package} daemon";
      Environment = [ "ATUIN_LOG=info" ];
      Restart = "on-failure";
      RestartSteps = 3;
      RestartMaxDelaySec = 6;
    };
  };
  systemd.user.sockets.atuin-daemon =
    let
      socket_dir =
        if lib.versionAtLeast config.home.packages.atuin.package.version "18.4.0" then "%t" else "%D/atuin";
    in
    {
      Unit = {
        Description = "Atuin daemon socket";
      };
      Install = {
        WantedBy = [ "sockets.target" ];
      };
      Socket = {
        ListenStream = "${socket_dir}/atuin.sock";
        SocketMode = "0600";
        RemoveOnStop = true;
      };
    };
}
