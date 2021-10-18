{ config, pkgs, ... }: 

{
  gtk = {
    enable = true;

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };

    font.name = "Iosevka Nerd Font, 10";

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
}
