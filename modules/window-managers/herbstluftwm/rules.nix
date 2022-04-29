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
    };
  };
}
