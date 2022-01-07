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

    getty = {
      autologinUser = "a";
    };

    openssh = {
      enable = true;
      permitRootLogin = "yes";
      passwordAuthentication = true;
    };
  };
}
