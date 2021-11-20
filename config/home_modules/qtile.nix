{ config, pkgs, ... }:

{
  xdg.configFile."qtile" = {
    target = "qtile";
    source = ../files/qtile;
    recursive = true;
  };
}
