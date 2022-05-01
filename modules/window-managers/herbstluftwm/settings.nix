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
      settings = {
        auto_detect_monitors = "on";
        focus_stealing_prevention = "false";
        hide_covered_windows = "on";
        mouse_recenter_gap = "0";
        smart_window_surroundings = "off";
        tree_style = "╾│ ├└╼─┐";

        always_show_frame = "on";
        default_frame_layout = "grid";
        frame_bg_active_color = "#1d2021";
        frame_bg_normal_color = "#1d2021";
        frame_bg_transparent = "on";
        frame_border_active_color = "#928374";
        frame_border_normal_color = "#282828";
        frame_border_width = "0";
        frame_gap = "0";
        frame_padding = "0";
        frame_transparent_width = "0";
        smart_frame_surroundings = "off";
      };
    };
  };
}
