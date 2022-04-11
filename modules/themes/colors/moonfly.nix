{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;

  polybarLayout = config.modules.programs.gui.misc.polybar.layout;
  rofiLayout = config.modules.programs.gui.misc.rofi.layout;

  background = "#080808";
  foreground = "#b2b2b2";
  bold       = "#eeeeee";
  cursor     = "#9e9e9e";
  selection  = "#b2ceee";

  nBlack     = "#323437";
  nRed       = "#ff5454";
  nGreen     = "#8cc85f";
  nYellow    = "#e3c78a";
  nBlue      = "#80a0ff";
  nPurple    = "#d183e8";
  nCyan      = "#79dac8";
  nWhite     = "#c6c6c6";

  bBlack     = "#949494";
  bRed       = "#ff5189";
  bGreen     = "#36c692";
  bYellow    = "#c2c292";
  bBlue      = "#74b2ff";
  bPurple    = "#ae81ff";
  bCyan      = "#85dc85";
  bWhite     = "#e4e4e4";

in


{
  config = mkIf (cfg.scheme == "moonfly") {
    modules = {
      theme = {
        wallpaper = config.wallpaperDir + "/tinged-city.jpg";
      };

      window-managers = {
        herbstluftwm.settings = (mkMerge [
          (mkIf (config.modules.theme.layout == "one") {
            active_color = nBlack;
            normal_color = "#000000";
            urgent_color = nRed;
          })
        ]);
      };

      programs = {
        gui = {
          terminals = {
            kitty = {
              colorScheme = builtins.readFile (config.configDir + "/kitty/colors/moonfly.conf");
            };
          };
          misc = {
            polybar = mkMerge [
              (mkIf (polybarLayout == "one") {
                scheme = {
                  bg = background;
                  fg = foreground;
                  active = bBlue;
                  accent = nYellow;
                  title = nPurple;
                };
              })
            ];

            rofi = mkMerge [
              (mkIf (rofiLayout == "one") {
                scheme = {
                  bg = background;
                  fg = foreground;
                  alt-bg = background;
                  alter-bg = background;
                  accent = nCyan;
                  border = "#000000";
                };
              })
            ];

            dunst = {
              urgencyLow = {
                background = background;
                foreground = foreground;
              };
              urgencyNormal = {
                background = background;
                foreground = foreground;
              };
              urgencyCritical = {
                background = background;
                foreground = foreground;
                frame_color = bRed;
              };
              frameColor = nGreen;
              seperatorColor = "#000000";
            };
          };
        };
        shell = {
          editors = {
            neovim = {
              colorScheme = "moonfly";
            };
          };
        };
      };
    };
  };
}
