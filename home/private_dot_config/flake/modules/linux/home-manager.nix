{
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
    packages = pkgs.callPackage ./packages.nix {};
    stateVersion = "25.05";
  };
}
