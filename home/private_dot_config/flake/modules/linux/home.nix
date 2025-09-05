{
  config,
  pkgs,
  neovim-nightly-overlay,
  nix-gl-host,
  ...
}: let
  user = "wangyizun";
in {
  imports = [
    ../shared
  ];

  home = {
    username = "${user}";
    homeDirectory = "/nas/${user}";
    packages = pkgs.callPackage ./packages.nix {inherit config;};
    stateVersion = "25.05";
  };

  nixpkgs.overlays = [
    neovim-nightly-overlay.overlays.default
    nix-gl-host.overlays.default
  ];
}
