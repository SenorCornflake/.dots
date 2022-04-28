
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;

  dataHome = config.home-manager.users."${config.userName}".xdg.dataHome;
  alternative_wallpaper = 
    (if (builtins.pathExists (dataHome + "/dotfiles/alternative_wallpaper"))
      then builtins.readFile (dataHome + "/dotfiles/alternative_wallpaper")
      else ""); # A wallpaper we can set with rofi that is used when no theme wallpaper is set
in

{
  options.modules.theme = {
    layout = mkOpt types.str "one";
    scheme = mkOpt types.str "base16";
    wallpaper = mkOpt types.str "";
    background = mkOpt types.str "#000000";
  };

  config = mkMerge [
    (mkIf true
      (let
        wallpaper =
          if (cfg.wallpaper != "")
          then cfg.wallpaper
          else if (alternative_wallpaper != "")
          then alternative_wallpaper
          else "${dataHome}/dotfiles/background.png";
        in {
          home-manager.users."${config.userName}" = {
            home.packages = with pkgs; [
              feh
              imagemagick
            ];

            xdg.dataFile."wallpaper" = {
              target = "dotfiles/wallpaper";
              recursive = false;
              executable = true;
               text = ''
                #!/usr/bin/env bash
                feh --no-fehbg --bg-fill ${wallpaper}
                convert -size 1920x1080 xc:${config.modules.theme.background} ${dataHome}/dotfiles/background.png
              '';
            };
          };
        }))
  ];
}
