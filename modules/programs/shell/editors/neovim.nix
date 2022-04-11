

{ inputs, config, lib, pkgs, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.shell.editors.neovim;
in

let
  flake-plugins = (pkgs.lib.genAttrs 
    [
      #"dial-nvim"
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
    }));
in
{
  options.modules.programs.shell.editors.neovim = {
    enable = mkBoolOpt true;
    colorScheme = mkOpt types.str "default";
  };

  config = mkIf cfg.enable {
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

      xdg.dataFile."colorscheme.txt" = {
        target = "nvim/colorscheme.txt";
        text = cfg.colorScheme; 
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

        plugins = with pkgs.vimPlugins; [
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
          (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
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
    };
  };
}
