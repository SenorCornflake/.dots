{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

  outputs = { self, nixpkgs, ... }@inputs: 

  let
    home_theme = ./home/themes/default.nix;

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.neovim-nightly.overlay
        inputs.nur.overlay
      ];
    };

    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      a = inputs.home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        username = "a";
        homeDirectory = "/home/a";
        stateVersion = "21.11";
        configuration = { config, pkgs, ... }: {
          imports = [
            ./home/main.nix
          ];
        };
        extraSpecialArgs = {
          theme = import home_theme;
        };
      };
    };

    nixosConfigurations = {
      slab = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/main.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
