

{ inputs, config, lib, pkgs, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types optionalAttrs;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.shell;

  fetchCommand = config.modules.programs.shell.fetchers.fetchCommand;

  terminal = if config.modules.desktop-environments.kde.enable
    then "konsole"
    else config.modules.programs.gui.terminals.default;
in
{
  options.modules.shell = mkOpt types.str "zsh";

  config = {
    home-manager.users."${config.userName}" = {
      home = {
        sessionVariables = {
          MANPAGER = "nvim +Man!";
          MANWIDTH = 999;
          EDITOR = "nvim";
          VISUAL = "nvim";
          TERMINAL = terminal;
          BROWSER = "firefox";
          VIDEO = "mpv";

          DOT_ROOT = config.dotsDir;
          WALL_ROOT = config.wallpaperDir;
          PATH = "~/.local/bin:$PATH";
          TODOTXT_CFG_FILE = "$XDG_CONFIG_HOME/todo/todo.cfg";
          SSH_ASKPASS = "";

          BAT_THEME="base16";

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

        shellAliases = {
          v = "nvim";
          vs = "sudoedit";
          hc = "herbstclient";
          f = "lfimg";
          lf = "lfimg";
          X = "startx ~/.config/xinit/xinitrc";
          t = "todo.sh -c";
          chmod_server = "sudo chmod -R 777 /srv/http && sudo chown -R wwwrun:wwwrun /srv/http && sudo chmod 755 /srv/http/phpmyadmin/config.inc.php";
          gp = "git push";
          gP = "git pull";
          gc = "git commit";
          ga = "git add";
          ls = (if config.modules.programs.shell.misc.exa.enable then "exa --git --icons" else "ls");
          weather = "curl -s \"wttr.in/$(echo \"$(curl -s https://ipinfo.io/)\" | jq -r '.city' | sed 's/ /+/g')\"";
        } // optionalAttrs (fetchCommand != "") { 
          fetch = fetchCommand;
        };
      };
    };
  };
}
