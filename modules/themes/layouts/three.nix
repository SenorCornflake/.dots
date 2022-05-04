{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;
in

{
  config = mkIf (cfg.layout == "three") {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      })
    ];

    modules = {
      window-managers = {
        herbstluftwm.layout = "three";
        picom = {
          inactiveDim = "0.08";
          shadowRadius = "10";
          shadowOffsets = [ "-10" "-10" ];
          shadowOpacity = "1.0";
          blur = true;
          blurStrength = "5";
          blurSize = "5";
        };
      };

      programs = {
        gui = {
          terminals = {
            kitty = {
              fontFamily = "Iosevka Nerd Font Mono";
              fontSize = 10;
              windowPaddingWidth = "15";
              backgroundOpacity = 0.9;
            };
          };
          misc = {
            polybar.layout = "three";
            rofi.layout = "three";
            dunst.layout = "three";
          };
        };
        shell = {
          editors = {
            neovim = {
              transparentBackground = true;
            };
          };
        };
      };
    };
  };
}
