{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    autorandr
  ];

  xdg.configFile."autorandr" = {
    target = "autorandr";
    source = ../files/autorandr;
    recursive = true;
  };
}
