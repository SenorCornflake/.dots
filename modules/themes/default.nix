
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) pathExists readFile;

  cfg = config.modules.theme;
  dataHome = config.dataHome;

  layoutFile = "${dataHome}/dotfiles/layout";
  schemeFile = "${dataHome}/dotfiles/scheme";

  alternative_wallpaper = 
    (if (builtins.pathExists (dataHome + "/dotfiles/alternative_wallpaper"))
      then builtins.readFile (dataHome + "/dotfiles/alternative_wallpaper")
      else ""); # A wallpaper we can set with rofi that is used when no theme wallpaper is set

  xresourcesData = (if pathExists "${config.dataHome}/dotfiles/Xresources" then readFile "${config.dataHome}/dotfiles/Xresources" else null); 
in

{
  options.modules.theme = {
    layout = mkOpt types.str "one";
    scheme = mkOpt types.str "base16";
    wallpaper = mkOpt types.str "";
    background = mkOpt types.str "#000000";

    iconTheme = mkOpt types.str "Adwaita";
    cursorTheme = mkOpt types.str "Adwaita";

    xresources = mkOpt (types.nullOr types.str) null;
  };

  config = let
    wallpaper =
      if (cfg.wallpaper != "")
      then cfg.wallpaper
      else if (alternative_wallpaper != "")
      then alternative_wallpaper
      else "${dataHome}/dotfiles/background.png";
    in
    {
      modules = {
        theme = {
          layout = if pathExists layoutFile then readFile layoutFile else "one";
          scheme = if pathExists schemeFile then readFile schemeFile else "base16";
        };
      };


      programs.dconf.enable = true;

      home-manager.users."${config.userName}" = {
        home.packages = with pkgs; [
          feh
          imagemagick
        ];


        home.file.".icons/default/index.theme" = {
          target = ".icons/default/index.theme";
          text = ''
            [icon theme]
            Name=Default
            Comment=Default Cursor Theme
            Inherits=${cfg.cursorTheme}
          '';
        };

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

        xresources.extraConfig = if cfg.xresources == null then xresourcesData else cfg.xresources;
      };
    };
}
