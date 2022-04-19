
{ inputs, config, lib, pkgs, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.shell.zsh;

  fetchCommand = config.modules.programs.shell.fetchers.fetchCommand;

  terminal = config.modules.programs.gui.terminals.default;
in
{
  config = mkIf (config.modules.shell == "zsh") {
    users.users."${config.userName}" = {
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;

    home-manager.users."${config.userName}" = {
      programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";

        history = {
          save = 1000;
          size = 1000;
          path = ".local/share/zsh/history";
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
          ":u" = "sh $DOT_ROOT/update.sh";
          ":h" = "sh $DOT_ROOT/install.sh home";
          ":s" = "sh $DOT_ROOT/install.sh system";
          ":a" = "sh $DOT_ROOT/install.sh all";
          X = "startx ~/.config/xinit/xinitrc";
          t = "todo.sh -c";
          chmod_server = "sudo chmod -R 777 /srv/http && sudo chown -R wwwrun:wwwrun /srv/http && sudo chmod 755 /srv/http/phpmyadmin/config.inc.php";
          gp = "git push";
          gP = "git pull";
          gc = "git commit";
          ga = "git add";
          ls = (if config.modules.programs.shell.misc.exa.enable then "exa --git --icons" else "ls");
          weather = "curl -s \"wttr.in/$(echo \"$(curl -s https://ipinfo.io/)\" | jq -r '.city' | sed 's/ /+/g')\"";
        } // (if (fetchCommand != "") then {
          fetch = fetchCommand;
        } else {});

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
            src = "${pkgs.zsh-vi-mode}";
            file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
          }
        ];

        sessionVariables = {
          MANPAGER = "nvim +Man!";
          MANWIDTH = 999;
          EDITOR = "nvim";
          VISUAL = "nvim";
          TERMINAL = terminal;
          BROWSER = "firefox";
          VIDEO = "mpv";

          DOT_ROOT = "$HOME/.dots";
          WALL_ROOT = config.wallpaperDir;
          WIKI_ROOT = "$XDG_DATA_HOME/wikis";
          PATH = "~/.local/bin:$PATH";
          TODOTXT_CFG_FILE = "$XDG_CONFIG_HOME/todo/todo.cfg";
          SSH_ASKPASS = "";

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

          PROMPT=' %F{blue}%~%f  '
        '' + (if (fetchCommand != "") then ''
          ${fetchCommand}
        '' else '''');

        # .zshenv
        envExtra = '''';
      };
    };
  };
}
