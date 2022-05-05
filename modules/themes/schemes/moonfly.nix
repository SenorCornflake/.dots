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
        herbstluftwm = (mkMerge [
          (mkIf (herbstluftwmLayout == "one") {
            attributes = {
              "theme.active.color" = nBlack;
              "theme.normal.color" = "#000000";
              "theme.urgent.color" = nRed;
            };
          })
          (mkIf (herbstluftwmLayout == "two" || herbstluftwmLayout == "two-compact") {
            attributes = {
              "theme.urgent.color" = nRed;
              "theme.urgent.inner_color" = nRed;
              "theme.urgent.outer_color" = nRed;

              "theme.active.color" = "#282828";
              "theme.active.outer_color" = "#282828";
              "theme.active.inner_color" = "#282828";
              "theme.active.title_color" = foreground;

              "theme.normal.color" = "#181818";
              "theme.normal.outer_color" = "#181818";
              "theme.normal.inner_color" = "#181818";
              "theme.normal.title_color" = bBlack;

              "theme.active.tab_color" = "#181818";
              "theme.active.tab_outer_color" = "#282828";
              "theme.active.tab_inner_color" = "#282828";
              "theme.active.tab_title_color" = bBlack;

              "theme.normal.tab_color" = background;
              "theme.normal.tab_outer_color" = "#181818";
              "theme.normal.tab_inner_color" = "#181818";
              "theme.normal.tab_title_color" = bBlack;
            };
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
              (mkIf (polybarLayout == "two" || polybarLayout == "two-compact") {
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
              (mkIf (rofiLayout == "two" || rofiLayout == "two-compact") {
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
              (mkIf (dunstLayout == "two" || dunstLayout == "two-compact") {
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
