{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url =          "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:rycee/home-manager/master";
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

    # Neovim plugin inputs (for plugins not officially packages on nix)
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
      url = "github:rrethy/nvim-base16";
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
    alpha-nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };
    kanagawa-nvim = {
      url = "github:rebelot/kanagawa.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, nixpkgs-stable, ... }: 

  let
    inherit (lib.my) mapHosts mapModules mapModulesRec mapModulesRecList;

    system = "x86_64-linux";
    pkgs-args = {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.neovim-nightly.overlay
        inputs.nur.overlay
        (final: prev: {
          commander = final.callPackage ./pkgs/commander {};
          phpmyadmin = final.callPackage ./pkgs/phpmyadmin {};
          extract-xiso = final.callPackage ./pkgs/extract-xiso {};
          xinput-gui = final.callPackage ./pkgs/xinput-gui {};
          neovim-command = final.callPackage ./pkgs/neovim-command {};
          schemer2 = final.callPackage ./pkgs/schemer2 {};
          auto-base16-theme = final.callPackage ./pkgs/auto-base16-theme {};
          haishoku = final.callPackage ./pkgs/haishoku {};
          pywal = final.callPackage ./pkgs/pywal {};
          picom-ibhagwan = final.callPackage ./pkgs/picom-ibhagwan {};
          picom-jonaburg-fix = final.callPackage ./pkgs/picom-jonaburg-fix {};
        })
      ];
    };
    pkgs = import nixpkgs pkgs-args;
    pkgs-unstable = import nixpkgs-unstable pkgs-args;
    pkgs-stable = import nixpkgs-stable pkgs-args;

    # Extend lib with my custom lib
    lib = nixpkgs.lib.extend
      (self: super: { my = import ./lib { inherit inputs lib pkgs; }; });
  in {
    nixosConfigurations =
      (mapHosts {
        inherit system;
        directory = ./hosts;
        extraModules =
          [ ./hosts/default.nix ] ++
          [ inputs.home-manager.nixosModules.home-manager ] ++
          (mapModulesRecList ./modules import);
        extraSpecialArgs = { inherit pkgs-unstable pkgs-stable; };
      });
  };
}
