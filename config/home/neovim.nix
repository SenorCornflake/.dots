{ inputs, config, pkgs, pkgs-unstable, pkgs-master, lib, style, ... }:

let
  # THANKS TO "https://breuer.dev/blog/nixos-home-manager-neovim"
  # installs a vim plugin from git with a given tag / branch
  /* vimPlugin = { repo, ref ? "HEAD" }: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  }; */

  # Flake approach for vim plugins, got from "https://github.com/SenchoPens/senixos/blob/master/profiles/nvim/default.nix"
  flake-plugins = (pkgs.lib.genAttrs 
    [
      "dial-nvim"
      "neo-tree-nvim"
      "nvim-scrollbar"
      "yankassassin-vim"
      "nvim-base16"
      "winshift-nvim"
      "material-nvim"
      "vim-enfocado"
      "vim-moonfly-colors"
      "catppuccin-nvim"
      "calvera-dark-nvim"
      "substrata-nvim"
      "monochrome-nvim"
      "zenbones-nvim"
    ]
    (plugin-name: pkgs.vimUtils.buildVimPlugin {
      name = plugin-name;  
      dontBuild = true;
      src = inputs.${plugin-name};
    })
  );
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
      yq
      coreutils
    ];

    plugins = with pkgs-master.vimPlugins; [
      # Deps
      nvim-web-devicons # dependancy for many plugins
      plenary-nvim # dependancy for many plugins
      lush-nvim # zenbones dependancy
      nui-nvim # neo tree dependancy

      # Plugs
      #symbols-outline-nvim
      bufferline-nvim
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      emmet-vim
      feline-nvim
      gitsigns-nvim
      hop-nvim
      kommentary
      lspkind-nvim
      luasnip
      nvim-autopairs
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter
      project-nvim
      surround-nvim
      targets-vim
      telescope-nvim
      vim-floaterm
      vim-fugitive
      vim-hexokinase
      vim-startuptime
      which-key-nvim

      gruvbox-material
      nord-nvim
      tokyonight-nvim
    ] ++ (pkgs.lib.mapAttrsToList (_: plugin: plugin) flake-plugins);
  };
}

