
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
    layout = mkOpt types.str "";
    scheme = mkOpt types.str "";
    wallpaper = mkOpt types.str "";
  };

  config = mkMerge [
    (mkIf true 
      (let
        wallpaper =
          if (cfg.wallpaper != "")
          then cfg.wallpaper
          else if (alternative_wallpaper != "")
          then alternative_wallpaper
          else "${config.wallpaperDir}/solid.png";
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
                #!${pkgs.bash}/bin/bash
                feh --no-fehbg --bg-fill ${wallpaper}
              '';
            };
          };
        }))

    (mkIf (cfg.scheme == "") {
      home-manager.users."${config.userName}" = {
      };
    })
    (mkIf (cfg.layout == "") {
      home-manager.users."${config.userName}" = {
      };
    })
  ];
}
