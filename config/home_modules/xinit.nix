{ config, pkgs, ... }:

{
  xdg.configFile."xinit/xinitrc" = {
    source = ../files/xinit/xinitrc;
    executable = true;
    target = "xinit/xinitrc";
  };
}
