

{ inputs, config, lib, pkgs, pkgs-unstable, pkgs-stable, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types toBool;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.shell.editors.neovim;
in

let
  flake-plugins = (pkgs.lib.genAttrs
    [
      "dial-nvim"
      "neo-tree-nvim"
      "nvim-scrollbar"
      "yankassassin-vim"
      "nvim-base16"
      "vim-enfocado"
      "vim-moonfly-colors"
      "calvera-dark-nvim"
      "substrata-nvim"
      "monochrome-nvim"
      "zenbones-nvim"
      "alpha-nvim"
      "kanagawa-nvim"
      "nvim-treesitter-context"
    ]
    (plugin-name: pkgs.vimUtils.buildVimPlugin {
      name = plugin-name;  
      dontBuild = true;
      src = inputs.${plugin-name};
    }));
in
{
  options.modules.programs.shell.editors.neovim = {
    enable = mkBoolOpt true;
    colorScheme = mkOpt types.str "default";
    transparentBackground = mkOpt types.bool false;
  };

  config = mkIf cfg.enable {
    fonts.fonts = with pkgs; [
      material-design-icons
    ];

    home-manager.users."${config.userName}" = {
      xdg.configFile."lua" = {
        target = "nvim/lua";
        source = (config.configDir + "/nvim/lua");
        recursive = true;
      };

      xdg.configFile."main.lua" = {
        target = "nvim/main.lua";
        source = (config.configDir + "/nvim/main.lua");
        recursive = false;
      };

      xdg.dataFile."neovim_colorscheme.txt" = {
        target = "dotfiles/neovim_colorscheme.txt";
        text = cfg.colorScheme; 
        recursive = false;
      };

      xdg.dataFile."neovim_transparent_background.txt" = {
        target = "dotfiles/neovim_transparent_background.txt";
        text = if cfg.transparentBackground then "true" else "false"; 
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
          pkgs-stable.sumneko-lua-language-server
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

        extraPython3Packages = (p: with p; [
          pynvim
          typer
          requests
        ]);

        plugins = with pkgs-unstable.vimPlugins; [
          # Deps
          lush-nvim # zenbones dependancy
          nui-nvim # neo tree dependancy
          nvim-web-devicons # dependancy for many plugins
          plenary-nvim # dependancy for many plugins

          # Plugs
          symbols-outline-nvim
          (nvim-treesitter.withPlugins (plugins: pkgs-unstable.tree-sitter.allGrammars))
          nvim-treesitter-refactor
          nvim-treesitter-textobjects
          nvim-ts-autotag
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
          project-nvim
          surround-nvim
          targets-vim
          telescope-nvim
          vim-floaterm
          lf-vim
          vim-fugitive
          vim-hexokinase
          vim-startuptime
          which-key-nvim
          winshift-nvim

          catppuccin-nvim
          gruvbox-material
          material-nvim
          nord-nvim
          tokyonight-nvim
        ] ++ (pkgs.lib.mapAttrsToList (_: plugin: plugin) flake-plugins);
      };
    };
  };
}
