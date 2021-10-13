{ config, pkgs, ... }:

{
  xdg.configFile."xinit/xinitrc" = {
    source = ../config/xinit/xinitrc;
    executable = true;
    target = "xinit/xinitrc";
  };
}
