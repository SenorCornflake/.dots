{ config, lib, pkgs, ... }:


let
  inherit (lib) mkIf recursiveUpdate types;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (pkgs) writeText;
  inherit (builtins) toJSON;
  cfg = config.modules.window-managers.herbstluftwm;

  Mod = "Mod4";
  Alt = "Mod1";
  resizestep = "0.02";
in

{
  config = mkIf cfg.enable {
    modules.window-managers.herbstluftwm = {
      keybinds = {
        "${Mod}-Shift-q" = "quit";
        "${Mod}-Shift-r" = "reload";
        "${Mod}-Shift-e" = "spawn autorandr --change";
        "${Mod}-w"       = "close";
        "${Mod}-Return"  = "spawn sh -c \"WXINIT_X11_SCALE_FACTOR=1 \${TERMINAL:-xterm}\"";
        # basic movement in tiling and floating mode
        # focusing clients
        "${Mod}-Left"  = "focus left";
        "${Mod}-Down"  = "focus down";
        "${Mod}-Up"    = " focus up";
        "${Mod}-Right" = "foccus right";
        "${Mod}-h"     = "focus left";
        "${Mod}-j"     = "focus down";
        "${Mod}-k"     = "focus up";
        "${Mod}-l"     = "focus right";
        # moving clients in tiling and floating mode
        "${Mod}-Shift-Left"  = "shift left";
        "${Mod}-Shift-Down"  = "shift down";
        "${Mod}-Shift-Up"    = "shift up";
        "${Mod}-Shift-Right" = "shift right";
        "${Mod}-Shift-h"     = "shift left";
        "${Mod}-Shift-j"     = "shift down";
        "${Mod}-Shift-k"     = "shift up";
        "${Mod}-Shift-l"     = "shift right";
        # splitting frames

        # create an empty frame at the specified direction
        "${Mod}-u" =                       "split   bottom  0.5";
        "${Mod}-o" =                       "split   right   0.5";
        "${Mod}-e" =                       "split explode";

        # resizing frames and floating clients
        "${Mod}-Control-h"     = "resize left +${resizestep}";
        "${Mod}-Control-j"     = "resize down +${resizestep}";
        "${Mod}-Control-k"     = "resize up +${resizestep}";
        "${Mod}-Control-l"     = "resize right +${resizestep}";
        "${Mod}-Control-Left"  = "resize left +${resizestep}";
        "${Mod}-Control-Down"  = "resize down +${resizestep}";
        "${Mod}-Control-Up"    = "resize up +${resizestep}";
        "${Mod}-Control-Right" = "resize right +${resizestep}";

        # cycle through tag
        "${Mod}-period" = "use_index +1 --skip-visible";
        "${Mod}-comma"  = "use_index -1 --skip-visible";

        # layouting
        "${Mod}-q"         = "move";
        "${Mod}-s"         = "floating toggle";
        "${Mod}-f"         = "fullscreen toggle";
        "${Mod}-Shift-f"   = "set_attr clients.focus.floating toggle";
        "${Mod}-Shift-m"   = "set_attr clients.focus.minimized true";
        "${Mod}-Control-m" = "jumpto last-minimized";
        "${Mod}-p"         = "pseudotile toggle";

        # The following cycles through the available layouts within a frame, but skips
        # layouts, if the layout change wouldn't affect the actual window positions.
        # I.e. if there are two windows within a frame, the grid layout is skipped.
        "${Mod}-space" = "or , and . compare tags.focus.curframe_wcount = 2 . cycle_layout +1 vertical horizontal max vertical grid , cycle_layout +1";

        # focus
        "${Mod}-d"         = "cycle_monitor";
        "${Mod}-Tab"       = "cycle +1";
        "${Mod}-Shift-Tab" = "cycle -1";
        "${Alt}-Tab"       = "cycle_all +1";
        "${Alt}-Shift-Tab" = "cycle_all -1";
        "${Mod}-i"         = "jumpto urgent";

        # custom
        "${Mod}-Insert" = "spawn keyboard_layout";
        "${Mod}-c"      = "spawn commander \"//\"";
        "${Mod}-a"      = "spawn rofi -modi drun -show drun";
        "${Alt}-a"      = "spawn rofi -modi window -show window";

        # Volume
        "F86AudioLowerVolume" = "spawn pulseaudio-ctl down";
        "F86AudioRaiseVolume" = "spawn pulseaudio-ctl up";
        "F86AudioMute"        = "spawn pulseaudio-ctl mute";

        # Scrots
        "${Mod}-F12" = "spawn -- flameshot full -p ~";

        # Brightness
        "${Mod}-XF86AudioRaiseVolume" = "spawn brightnessctl s 10%+";
        "${Mod}-XF86AudioLowerVolume" = "spawn brightnessctl s 10%-";

        # Sleep
        "${Mod}-Escape" = "spawn systemctl suspend";

        # Rotate frame
        "${Mod}-r" = "rotate";

        # Notifications
        "Control-Shift-period" =  "spawn dunstctl context";
        "Control-Shift-space"  =  "spawn dunstctl close-all";
        "Control-space"        =  "spawn dunstctl close";
        "Control-Shift-grave"  =  "spawn dunstctl history-pop";
      };
      mousebinds = {
        "${Mod}-Button1" =  "move";
        "${Mod}-Button2" =  "zoom";
        "${Mod}-Button3" =  "resize";
      };
    };
  };
}
