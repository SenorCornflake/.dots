{ config, pkgs, ... }:

{
  xdg.configFile."xinit/xinitrc" = {
    source = ../files/xinit/herbstluftwm;
    executable = true;
    target = "xinit/xinitrc";
  };
}
