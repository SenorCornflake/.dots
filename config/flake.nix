{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: 

  let
    t = builtins.readFile ../scripts/storage/theme.txt;
    l = builtins.readFile ../scripts/storage/layout.txt;

    theme = import (./. + "/home/themes/${t}.nix") { inherit pkgs lib; };
    layout = import (./. + "/home/layouts/${l}.nix") { inherit pkgs lib; };

    style = lib.recursiveUpdate theme layout;

    system = "x86_64-linux";

    pkgs-opts = {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.neovim-nightly.overlay
        inputs.nur.overlay
        /* (final: prev: {
          custom-dwarf-fortress-packages = final.callPackage ./pkgs/dwarf-fortress {};
        }) */
      ];
    };

    pkgs = import nixpkgs pkgs-opts;
    pkgs-unstable = import nixpkgs-unstable pkgs-opts;

    lib = nixpkgs.lib;

    mkSystem = name: lib.nixosSystem {
      inherit system;
      modules = [
        ./system/main.nix
        (./. + "/system/hardware-configurations/${name}.nix")
      ];
      specialArgs = { inherit inputs pkgs-unstable; };
    };
  in {
    homeManagerConfigurations = {
      a = inputs.home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "a";
        homeDirectory = "/home/a";
        stateVersion = "21.11";
        configuration = { config, pkgs, pkgs-unstable, ... }: {
          imports = [
            ./home/main.nix
          ];
        };
        extraSpecialArgs = {
          style = style;
        };
      };
    };

    nixosConfigurations = {
      t440p = mkSystem "t440p";
    };
  };
}
