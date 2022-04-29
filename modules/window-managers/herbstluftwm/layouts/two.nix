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
        herbstluftwm = {
          settings = {
            window_gap = "15";
          };
          attributes = {
            "theme.border_width" = "3";
            "theme.title_height" = "20";
            "theme.title_align" = "center";
            "theme.title_depth" = "10";
            "theme.title_font" = "Iosevka Nerd Font:size=10:weight=bold";
            "theme.outer_width" = "3";
            "theme.inner_width" = "3";
          };
        };
      };
    };
  };
}
