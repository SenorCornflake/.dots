{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types mapAttrs;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) readFile pathExists fromJSON replaceStrings;
  cfg = config.modules.theme;

  dataHome = "/home/${config.userName}/.local/share/";

  polybarLayout = config.modules.programs.gui.misc.polybar.layout;
  rofiLayout = config.modules.programs.gui.misc.rofi.layout;
  dunstLayout = config.modules.programs.gui.misc.dunst.layout;
  herbstluftwmLayout = config.modules.window-managers.herbstluftwm.layout;

  base16 = mapAttrs
    (n: v: "#" + v)
    (if (pathExists (dataHome + "/dotfiles/base16.json"))
     then fromJSON (readFile (dataHome + "/dotfiles/base16.json"))
     else {
      base00 = "181818";
      base01 = "282828";
      base02 = "383838";
      base03 = "585858";
      base04 = "b8b8b8";
      base05 = "d8d8d8";
      base06 = "e8e8e8";
      base07 = "f8f8f8";
      base08 = "ab4642";
      base09 = "dc9656";
      base0A = "f7ca88";
      base0B = "a1b56c";
      base0C = "86c1b9";
      base0D = "7cafc2";
      base0E = "ba8baf";
      base0F = "a16946";
    });

  inherit (base16) base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;
in

{
  config = mkIf (cfg.scheme == "base16") {
    modules = {
      theme.background = base00;

      window-managers = {
        herbstluftwm = (mkMerge [
          (mkIf (herbstluftwmLayout == "one") {
            attributes = {
              "theme.active.color" = base02;
              "theme.normal.color" = base01;
              "theme.urgent.color" = base09;
            };
          })
          (mkIf (herbstluftwmLayout == "two" || herbstluftwmLayout == "two-compact") {
            attributes = {
              "theme.urgent.color" = base09;
              "theme.urgent.inner_color" = base09;
              "theme.urgent.outer_color" = base09;

              "theme.active.color" = base02;
              "theme.active.outer_color" = base02;
              "theme.active.title_color" = base07;
              "theme.active.inner_color" = base02;

              "theme.normal.color" = base01;
              "theme.normal.outer_color" = base01;
              "theme.normal.title_color" = base05;
              "theme.normal.inner_color" = base01;

              "theme.active.tab_color" = base01;
              "theme.active.tab_outer_color" = base02;
              "theme.active.tab_inner_color" = base02;
              "theme.active.tab_title_color" = base05;

              "theme.normal.tab_color" = base00;
              "theme.normal.tab_outer_color" = base01;
              "theme.normal.tab_inner_color" = base01;
              "theme.normal.tab_title_color" = base05;
            };
          })
          (mkIf (herbstluftwmLayout == "three") {
            attributes = {
              "theme.urgent.color" = base09;

              "theme.active.color" = base0C;
              "theme.active.title_color" = base0C;

              "theme.normal.color" = base01;
              "theme.normal.title_color" = base01;

              "theme.active.tab_color" = base01;
              "theme.active.tab_title_color" = base01;

              "theme.normal.tab_color" = base00;
              "theme.normal.tab_title_color" = base00;
            };
          })
        ]);
      };

      programs = {
        gui = {
          terminals = {
            kitty = {
              colorScheme =
                if (pathExists (dataHome + "/dotfiles/kitty.conf"))
                then (readFile (dataHome + "/dotfiles/kitty.conf"))
                else "";
            };
          };
          misc = {
            polybar = mkMerge [
              (mkIf (polybarLayout == "one") {
                scheme = {
                  bg = base00;
                  fg = base07;
                  active = base0C;
                  accent = base0F;
                  title = base0D;
                  border = base01;
                };
              })
              (mkIf (polybarLayout == "two" || polybarLayout == "two-compact") {
                scheme = {
                  bg = base00;
                  fg = base05;
                  decor = base01;
                  icons = base0E;
                  empty = base02;
                  urgent = base09;
                  other = base0D;
                  indicators = base0E;
                };
              })
              (mkIf (polybarLayout == "three") {
                scheme = {
                  bg = "#E6" + (replaceStrings ["#"] [""] base00);
                  module-bg = base00;
                  fg = base05;
                  sep = base02;
                  accent = base0E;
                  empty = base03;
                };
              })
            ];

            rofi = mkMerge [
              (mkIf (rofiLayout == "one") {
                scheme = {
                  bg = base00;
                  fg = base07;
                  alt-bg = base00;
                  alter-bg = base00;
                  accent = base0D;
                  border = base01;
                };
              })
              (mkIf (rofiLayout == "two" || rofiLayout == "two-compact") {
                scheme = {
                  bg = base00;
                  fg = base07;
                  alt-bg = base02;
                  accent = base0E;
                  border = base02;
                };
              })
              (mkIf (rofiLayout == "three") {
                scheme = {
                  bg = "#" + (replaceStrings ["#"] [""] base00) + "E6";
                  fg = base07;
                  alt-bg = "#" + (replaceStrings ["#"] [""] base00) + "E6";
                  accent = base0E;
                };
              })
            ];

            dunst = mkMerge [
              (mkIf (dunstLayout == "one") {
                urgencyLow = {
                  background = base00;
                  foreground = base07;
                };
                urgencyNormal = {
                  background = base00;
                  foreground = base07;
                };
                urgencyCritical = {
                  background = base00;
                  foreground = base07;
                  frame_color = base09;
                };
                frameColor = base0B;
                seperatorColor = base00;
              })
              (mkIf (dunstLayout == "two" || dunstLayout == "two-compact") {
                urgencyLow = {
                  background = base00;
                  foreground = base07;
                };
                urgencyNormal = {
                  background = base00;
                  foreground = base07;
                };
                urgencyCritical = {
                  background = base00;
                  foreground = base07;
                  frame_color = base09;
                };
                frameColor = base0A;
                seperatorColor = base02;
              })
              (mkIf (dunstLayout == "three") {
                urgencyLow = {
                  background = "#" + (replaceStrings ["#"] [""] base00) + "E6";
                  foreground = base07;
                };
                urgencyNormal = {
                  background = "#" + (replaceStrings ["#"] [""] base00) + "E6";
                  foreground = base07;
                };
                urgencyCritical = {
                  background = "#" + (replaceStrings ["#"] [""] base00) + "E6";
                  foreground = base07;
                  frame_color = base09;
                };
                frameColor = base0A;
                seperatorColor = base02;
              })
            ];
          };
        };
        shell = {
          editors = {
            neovim = {
              colorScheme = "base16";
            };
          };
        };
      };
    };
  };
}
