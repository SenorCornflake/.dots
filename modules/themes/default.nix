
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.theme;
in

{
  options.modules.theme = {
    layout = mkOpt types.str "";
    scheme = mkOpt types.str "";
    wallpaper = mkOpt types.path "${config.wallpaperDir}/solid.png";
  };

  config = mkMerge [
    (mkIf true {
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
            convert -size 1920x1080 xc:${config.modules.programs.gui.misc.polybar.scheme.bg} ${config.wallpaperDir}/solid.png
            feh --no-fehbg --bg-fill "${cfg.wallpaper}"
          '';
        };
      };
    })

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
