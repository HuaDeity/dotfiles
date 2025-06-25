{ neovim-nightly-overlay, ... }:

let
  overlays = [
    neovim-nightly-overlay.overlays.default
  ];
in

{
  imports = [
    ../../modules/linux/home-manager.nix
    ../../modules/shared
  ];

  nixpkgs.overlays = overlays;
}
