{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

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

    # Non Flakes
    ## Neovim Plugins
    dial-nvim = {
      url = "github:monaqa/dial.nvim";
      flake = false;
    };
    neo-tree-nvim = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
    nvim-scrollbar = {
      url = "github:petertriho/nvim-scrollbar";
      flake = false;
    };
    yankassassin-vim = {
      url = "github:svban/YankAssassin.vim";
      flake = false;
    };
    nvim-base16 = {
      url = "github:SenorCornflake/nvim-base16";
      flake = false;
    };
    winshift-nvim = {
      url = "github:sindrets/winshift.nvim";
      flake = false;
    };
    material-nvim = {
      url = "github:marko-cerovac/material.nvim";
      flake = false;
    };
    vim-enfocado = {
      url = "github:wuelnerdotexe/vim-enfocado";
      flake = false;
    };
    vim-moonfly-colors = {
      url = "github:bluz71/vim-moonfly-colors";
      flake = false;
    };
    catppuccin-nvim = {
      url = "github:catppuccin/nvim";
      flake = false;
    };
    calvera-dark-nvim = {
      url = "github:yashguptaz/calvera-dark.nvim";
      flake = false;
    };
    substrata-nvim = {
      url = "github:kvrohit/substrata.nvim";
      flake = false;
    };
    monochrome-nvim = {
      url = "github:kdheepak/monochrome.nvim";
      flake = false;
    };
    zenbones-nvim = {
      url = "github:mcchrish/zenbones.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-master, ... }@inputs: 

  let
    theme_name = builtins.readFile ../scripts/storage/theme.txt;
    layout_name = builtins.readFile ../scripts/storage/layout.txt;

    theme = import (./. + "/home/themes/${theme_name}.nix") { inherit pkgs lib; };
    layout = import (./. + "/home/layouts/${layout_name}.nix") { inherit pkgs lib; };

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
    pkgs-master = import nixpkgs-master pkgs-opts;

    lib = nixpkgs.lib;

    mkSystem = name: lib.nixosSystem {
      inherit system;
      modules = [
        ./system/main.nix
        (./. + "/system/hardware-configurations/${name}.nix")
      ];
      specialArgs = { inherit inputs pkgs-unstable pkgs-master; };
    };
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
          inherit inputs style pkgs-unstable pkgs-master;
        };
      };
    };

    nixosConfigurations = {
      t440p = mkSystem "t440p";
    };
  };
}
