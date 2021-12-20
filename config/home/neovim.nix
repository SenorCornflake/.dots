{ config, pkgs, lib, style, ... }:

let
  # THANKS TO "https://breuer.dev/blog/nixos-home-manager-neovim"

  # installs a vim plugin from git with a given tag / branch
  vimPlugin = { repo, ref ? "HEAD" }: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in {

  xdg.configFile."lua" = {
    target = "nvim/lua";
    source = ../files/nvim/lua;
    recursive = true;
  };

  xdg.configFile."main.lua" = {
    target = "nvim/main.lua";
    source = ../files/nvim/main.lua;
    recursive = false;
  };

  xdg.dataFile."colorscheme.txt" = {
    target = "nvim/colorscheme.txt";
    source = pkgs.writeText "neovim_colorscheme" style.neovim.colorscheme; 
    recursive = false;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    package = pkgs.neovim-nightly;

    extraConfig = ''
      luafile ~/.config/nvim/main.lua
    '';

    extraPackages = with pkgs; [
      tree-sitter
      gcc
      bat
      ripgrep
      /* qtile */

      # Language servers
      rnix-lsp
      sumneko-lua-language-server
      rust-analyzer
      nodePackages.typescript-language-server
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-json-languageserver-bin
      nodePackages.pyright
      nodePackages.intelephense
    ];

    plugins = with pkgs.vimPlugins; [
      # Deps
      plenary-nvim
      nvim-web-devicons

      # Plugs
      nvim-lspconfig
      nvim-compe
      nvim-cmp
      cmp-buffer
      cmp-nvim-lsp
      cmp_luasnip
      cmp-path
      luasnip
      nvim-treesitter
      vim-floaterm
      telescope-nvim
      vim-startuptime
      bufferline-nvim
      gitsigns-nvim
      symbols-outline-nvim
      hop-nvim
      vim-hexokinase
      lspkind-nvim
      vim-fugitive
      nvim-autopairs
      kommentary
      feline-nvim
      emmet-vim
      #indent-blankline-nvim
      gruvbox-material
      nvim-base16

      (vimPlugin {
        repo = "blackCauldron7/surround.nvim";
      })
      (vimPlugin {
        repo = "sindrets/winshift.nvim";
      })
      (vimPlugin {
        repo = "ahmedkhalf/project.nvim";
      })
      (vimPlugin {
        repo = "vijaymarupudi/nvim-fzf";
      })
      (vimPlugin {
        repo = "ibhagwan/fzf-lua";
      })
      (vimPlugin {
        repo = "marko-cerovac/material.nvim";
      })
      (vimPlugin {
        repo = "wuelnerdotexe/vim-enfocado";
      })
      (vimPlugin {
        repo = "folke/tokyonight.nvim";
      })
      (vimPlugin {
        repo = "bluz71/vim-moonfly-colors";
      })
      (vimPlugin {
        repo = "catppuccin/nvim";
      })
    ];
  };
}

