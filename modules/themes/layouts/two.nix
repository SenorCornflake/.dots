{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;
in

{
  config = mkIf (cfg.layout == "two") {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      })
    ];

    modules = {
      window-managers = {
        herbstluftwm.layout = "two";
        picom = {
          inactiveDim = "0.08";
          shadowRadius = "10";
          shadowOffsets = [ "-10" "-10" ];
          shadowOpacity = "1.0";
        };
      };

      programs = {
        gui = {
          terminals = {
            kitty = {
              fontFamily = "Iosevka Nerd Font Mono";
              fontSize = 10;
              windowPaddingWidth = "15";
            };
          };
          misc = {
            polybar.layout = "two";
            rofi.layout = "two";
            dunst.layout = "two";
          };
        };
      };
    };
  };
}
