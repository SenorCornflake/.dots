{ config, lib, pkgs, ... }:


let
  inherit (lib) mkIf recursiveUpdate types;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (pkgs) writeText;
  inherit (builtins) toJSON;
  cfg = config.modules.window-managers.herbstluftwm;
in

{
  config = mkIf cfg.enable {
    modules.window-managers.herbstluftwm = {
      rules = [
        "focus=on # normally focus new clients"
        "floatplacement=smart"
        "windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' floating=on"
        "windowtype='_NET_WM_WINDOW_TYPE_DIALOG' focus=on"
        "windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off"
        "class=\"dragon-drag-and-drop\" floating=on"
      ];
      extraConfig = ''
        hc() {
            herbstclient "$@"
        }

        tag_names=( {1..9} 0 )
        tag_keys=( {1..9} 0 )

        hc rename default "''${tag_names[0]}" || true
        for i in "''${!tag_names[@]}" ; do
            hc add "''${tag_names[$i]}"
            key="''${tag_keys[$i]}"
            if ! [ -z "$key" ] ; then
                hc keybind "$Mod-$key" use_index "$i"
                hc keybind "$Mod-Shift-$key" move_index "$i"
            fi
        done

        # AUTOSTART
        # Notification daemon
        killall dunst

        # X settings
        xset r 66 # Enable repeat for capslock key
        xkbset ma 1 5 70 6 0
        xkbset exp 60 =mousekeys

        # Enable nightmode if it was enabled prior to restarting
        restore_nightmode_state

        # Wallpaper
        sh $XDG_DATA_HOME/dotfiles/wallpaper

        hc detect_monitors

        # Reload systemd units
        systemctl --user restart picom
        systemctl --user restart polybar
        systemctl --user restart polkit_gui

        # Setup monitors if it is the first time this config is running since starting X server
        if [[ -f "$XDG_DATA_HOME/herbstluftwm/first_start.txt" ]]; then
            rm "$XDG_DATA_HOME/herbstluftwm/first_start.txt"
            autorandr --change
        fi

        # Check if dots repo is up to date with remote
        pushd $DOT_ROOT
        git remote update

        status=$(git status -uno)
        if [[ $(echo $status | grep -w "is up to date") ]]; then
            notify-send "Local and remote are equal" -a "dots"
        elif [[ $(echo $status | grep -w "is ahead of") ]]; then
            notify-send "Local is ahead of remote, please push commits" -a "dots"
        else
            notify-send "Remote is ahead of local, please pull commits" -a "dots"
        fi
        popd
      '';
    };
  };
}
