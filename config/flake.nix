{
  description = "Configuration";

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
  in
    {
      homeManagerConfigurations = {
        a = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "a";
          homeDirectory = "/home/a";
          stateVersion = "21.11";
          configuration = { config, pkgs, ... }: {
            imports = [
              ./home_modules/neovim.nix
              ./home_modules/zsh.nix
              ./home_modules/kitty.nix
              ./home_modules/exa.nix
              ./home_modules/home-manager.nix
              ./home_modules/picom.nix
              ./home_modules/polybar.nix
              ./home_modules/lf.nix
              ./home_modules/dunst.nix
              ./home_modules/rofi.nix
              ./home_modules/firefox.nix
              ./home_modules/qt.nix
              ./home_modules/gtk.nix
              ./home_modules/xdg.nix
              ./home_modules/herbstluftwm.nix
              ./home_modules/autorandr.nix
              ./home_modules/xinit.nix
              ./home_modules/git.nix
              ./home_modules/packages.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        slab = lib.nixosSystem {
          inherit system;
          modules = [
            ./system_modules/main.nix
            ./system_modules/fonts.nix
            ./system_modules/users.nix
            ./system_modules/bootloader.nix
            ./system_modules/webserver.nix
          ];
        };
      };
  };
}
