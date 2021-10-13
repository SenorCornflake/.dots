{ config, pkgs, ... }: 

{
  gtk = {
    enable = true;

    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };

    font.name = "Iosevka Nerd Font, 10";
  };
}
