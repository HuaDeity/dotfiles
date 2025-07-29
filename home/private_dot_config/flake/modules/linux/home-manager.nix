{
  config,
  pkgs,
  nixgl,
  ...
}: let
  user = "wangyizun";
in {
  nixGL.packages = nixgl.packages;

  home = {
    username = "${user}";
    homeDirectory = "/nas/${user}";
    packages = pkgs.callPackage ./packages.nix {inherit config;};
    stateVersion = "25.05";
  };
}
