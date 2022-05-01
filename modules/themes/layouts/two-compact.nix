{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;
in

{
  config = mkIf (cfg.layout == "two-compact") {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      })
    ];

    modules = {
      window-managers = {
        herbstluftwm.layout = "two-compact";
        picom = {
          inactiveDim = "0.08";
          shadowRadius = "5";
          shadowOffsets = [ (-5) (-5) ];
          shadowOpacity = "1.0";
        };
      };

      programs = {
        gui = {
          terminals = {
            kitty = {
              fontFamily = "Iosevka Nerd Font Mono";
              fontSize = 10;
              windowPaddingWidth = "10";
            };
          };
          misc = {
            polybar.layout = "two-compact";
            rofi.layout = "two-compact";
            dunst.layout = "two-compact";
          };
        };
      };
    };
  };
}
