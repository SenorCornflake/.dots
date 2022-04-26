{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;
in

{
  config = mkIf (cfg.layout == "one") {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      })
    ];

    modules = {
      window-managers = {
        herbstluftwm.layout = "one";
        picom = {
          inactiveDim = "0.08";
        };
      };

       programs = {
         gui = {
           terminals = {
             kitty = {
               fontFamily = "Iosevka Nerd Font";
               fontSize = 10;
               windowPaddingWidth = "10";
             };
           };
           misc = {
             polybar.layout = "one";
             rofi.layout = "one";
             dunst.layout = "one";
           };
         };
       };
    };
  };
}
