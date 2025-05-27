{
  pkgs,
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
    stateVersion = "24.11";
  };
}
