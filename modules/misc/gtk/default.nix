{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types;
  cfg = config.modules.misc.gtk;
in

let 
  themes = {
    adwaita-dark = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };
  icon-themes = {
    adwaita = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
  };
in {
  options.modules.misc.gtk = {
    enable = mkBoolOpt true;
    themes = mkOpt types.attrs themes;
    icon-themes = mkOpt types.attrs icon-themes;
    theme = mkOpt types.attrs themes.adwaita-dark;
    icon-theme = mkOpt types.attrs icon-themes.adwaita;
    font = mkOpt types.str "Cantarell, 10";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      gtk = {
        enable = true;

        iconTheme = cfg.icon-theme;
        theme = cfg.theme;
        font.name = cfg.font;

        gtk2.configLocation = "${config.home-manager.users."${config.userName}".xdg.configHome}/gtk-2.0/gtkrc";
      };
    };

    programs.dconf.enable = true;
  };
}
