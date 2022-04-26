{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;

  polybarLayout = config.modules.programs.gui.misc.polybar.layout;
  rofiLayout = config.modules.programs.gui.misc.rofi.layout;
  dunstLayout = config.modules.programs.gui.misc.dunst.layout;
  herbstluftwmLayout = config.modules.window-managers.herbstluftwm.layout;

  background = "#080808";
  foreground = "#b2b2b2";
  bold       = "#eeeeee";
  cursor     = "#9e9e9e";
  selection  = "#b2ceee";

  nBlack     = "#323437";
  nRed      = "#ff5454";
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
        background = background;
        wallpaper = "${config.wallpaperDir}/clear-moon.jpg";
      };

      window-managers = {
        herbstluftwm.settings = (mkMerge [
          (mkIf (herbstluftwmLayout == "one") {
            active_color = nBlack;
            normal_color = "#000000";
            urgent_color = nRed;
          })
          (mkIf (herbstluftwmLayout == "two") {
            urgent_color = nRed;
            urgent_inner_color = nRed;
            urgent_outer_color = nRed;

            active_color = "#282828";
            active_outer_color = "#282828";
            active_inner_color = "#282828";
            active_title_color = foreground;

            normal_color = "#181818";
            normal_outer_color = "#181818";
            normal_inner_color = "#181818";
            normal_title_color = bBlack;

            active_tab_color = "#181818";
            active_tab_outer_color = "#282828";
            active_tab_inner_color = "#282828";
            active_tab_title_color = bBlack;

            normal_tab_color = background;
            normal_tab_outer_color = "#181818";
            normal_tab_inner_color = "#181818";
            normal_tab_title_color = bBlack;
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
                  border = "#000000";
                };
              })
              (mkIf (polybarLayout == "two") {
                scheme = {
                  bg = background;
                  fg = foreground;
                  decor = "#181818";
                  icons = nBlue;
                  empty = nBlack;
                  urgent = nRed;
                  misc = nGreen;
                  indicators = nPurple;
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
              (mkIf (rofiLayout == "two") {
                scheme = {
                  bg = background;
                  fg = foreground;
                  alt-bg = nBlack;
                  accent = nYellow;
                  border = nBlack;
                };
              })
            ];

            dunst = mkMerge [
              (mkIf (dunstLayout == "one") {
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
              })
              (mkIf (dunstLayout == "two") {
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
                frameColor = bCyan;
                seperatorColor = nBlack;
              })
            ];
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
