{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    history = {
      save = 1000;
      size = 1000;
      path = "$XDG_DATA_HOME/zsh/history";
    };
    
    completionInit = ''
      autoload -U compinit && compinit -d ~/.config/zsh/zcompdump
    '';

    shellAliases = {
      v = "nvim";
      vs = "sudoedit";
      r = "ranger";
      hc = "herbstclient";
      f = "lf";
      fetch = "macchina -p -t Boron --no-box";
      _u = "sh $DOT_ROOT/update.sh";
      _h = "sh $DOT_ROOT/install.sh home";
      _s = "sh $DOT_ROOT/install.sh system";
      _a = "sh $DOT_ROOT/install.sh all";
      X = "startx ~/.config/xinit/xinitrc";
      t = "todo.sh -c";
    };

    plugins = [ 
      {
        name = "zsh-fast-syntax-highlighting";
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        src = "${pkgs.zsh-fast-syntax-highlighting}";
      }
      {
        name = "zsh-autosuggestions";
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        src = "${pkgs.zsh-autosuggestions}";
      }
      {
        name = "zsh-history-substring-search";
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
        src = "${pkgs.zsh-history-substring-search}";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "5eb9c43f941a3ac419584a5c390aeedf4916b245";
            sha256 = "0qfzai7319ndi81crlpxfkpl1ry3hyjr87q7n6y5s6s4kgq38swr";
        };
      }
    ];
    
    sessionVariables = {
      MANPAGER = "nvim +Man!";
      MANWIDTH = 999;
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      BROWSER = "firefox";
      VIDEO = "mpv";

      DOT_ROOT = "$HOME/.dots";
      WALL_ROOT = "$HOME/Pictures/wallpapers";
      PATH = "~/.local/bin:$PATH";
      TODOTXT_CFG_FILE = "$XDG_CONFIG_HOME/todo/todo.cfg";

      NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc";

      # Highlight man pages in less (keep this there even though i use neovim for man pages)
      LESS_TERMCAP_mb = "$(tput bold; tput setaf 2)";
      # Start bold
      LESS_TERMCAP_md = "$(tput bold; tput setaf 2)"; # green
      # Start stand out
      LESS_TERMCAP_so = "$(tput bold; tput setaf 3)"; # yellow
      # End standout
      LESS_TERMCAP_se = "$(tput rmso; tput sgr0)";
      # Start underline
      LESS_TERMCAP_us = "$(tput smul; tput bold; tput setaf 1)"; # red
      # End Underline
      LESS_TERMCAP_ue = "$(tput sgr0)";
      # End bold, blinking, standout, underline
      LESS_TERMCAP_me = "$(tput sgr0)";
    };

    # .zshrc
    initExtra = ''
      ZVM_VI_INSERT_ESCAPE_BINDKEY=kj

      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey "\e[3~" delete-char 

      autoload edit-command-line; zle -N edit-command-line
      bindkey '^v' edit-command-line

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list ${"''"} 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # match all case
      _comp_options+=(globdots) # complete hidden files
      bindkey '^[[Z' reverse-menu-complete

      any-nix-shell zsh --info-right | source /dev/stdin

      PROMPT=' %F{blue}%~%f > '
      macchina -p -t Boron --no-box
    '';

    # .zshenv
    envExtra = '''';
  };
}
