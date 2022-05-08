{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.window-managers.herbstluftwm;
in

{
  config = mkIf (cfg.layout == "two-compact") {
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
            window_gap = "10";
          };
          attributes = {
            "theme.border_width" = "2";
            "theme.title_height" = "18";
            "theme.title_align" = "center";
            "theme.title_depth" = "6";
            "theme.title_font" = "Iosevka Nerd Font:size=10:weight=bold";
            "theme.outer_width" = "2";
            "theme.inner_width" = "2";
          };
        };
      };
    };
  };
}
