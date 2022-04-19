{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types mapAttrs;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) readFile pathExists fromJSON;
  cfg = config.modules.theme;

  dataHome = config.home-manager.users."${config.userName}".xdg.dataHome;

  polybarLayout = config.modules.programs.gui.misc.polybar.layout;
  rofiLayout = config.modules.programs.gui.misc.rofi.layout;

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
      window-managers = {
        herbstluftwm.settings = (mkMerge [
          (mkIf (config.modules.theme.layout == "one") {
            active_color = base02;
            normal_color = base00;
            urgent_color = base09;
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
            ];

            rofi = mkMerge [
              (mkIf (rofiLayout == "one") {
                scheme = {
                  bg = base00;
                  fg = base07;
                  alt-bg = base00;
                  alter-bg = base00;
                  accent = base0E;
                  border = base01;
                };
              })
            ];

            dunst = {
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
            };
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
