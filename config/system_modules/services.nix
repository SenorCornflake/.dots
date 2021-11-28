{ config, pkgs, ...}: 

{
  services = {
    xserver = {
      enable = true;
      layout = "us";
      displayManager.startx.enable = true;
    };

    gvfs = {
      enable = true;
    };

    gnome = {
      glib-networking = {
        enable = true;
      };
    };
  };
}
