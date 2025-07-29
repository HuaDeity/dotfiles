{
  description = "Starter Configuration for MacOS and Linux";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = {...} @ inputs: let
    linuxSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    darwinSystems = [
      "aarch64-darwin"
    ];
    forAllSystems = f: inputs.nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
    devShell = system: let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      default = with pkgs;
        mkShell {
          nativeBuildInputs = with pkgs; [
            bashInteractive
            git
          ];
          shellHook = ''
            export EDITOR=vim
          '';
        };
    };
  in {
    devShells = forAllSystems devShell;

    darwinConfigurations = inputs.nixpkgs.lib.genAttrs darwinSystems (
      system:
        inputs.darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            inputs.home-manager.darwinModules.home-manager
            ./hosts/darwin
          ];
        }
    );

    homeConfigurations = inputs.nixpkgs.lib.genAttrs linuxSystems (
      system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = inputs;
          modules = [
            inputs.index-database.homeModules.nix-index
            ./hosts/linux
          ];
        }
    );
  };
}
