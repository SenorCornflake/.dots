{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.window-managers.herbstluftwm;
in

{
  config = mkIf (cfg.layout == "two") {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      })
      terminus_font
    ];
    modules = {
      window-managers = {
        herbstluftwm.settings = {
          border_width = "3";
          window_gap = "15";
          title_height = "20";
          title_align = "center";
          title_depth = "10";
          title_font = "Iosevka Nerd Font:size=10:weight=bold";
          outer_width = "3";
          inner_width = "3";
        };
      };
    };
  };
}
