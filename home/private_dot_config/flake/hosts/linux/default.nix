{ inputs, ... }:

let
  overlays = [
    inputs.neovim-nightly-overlay.overlays.default
  ];
in

{
  imports = [
    ../../modules/linux/home-manager.nix
    ../../modules/shared
  ];

  nixpkgs.overlays = overlays;
}
