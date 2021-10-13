{ config, pkgs, ... }:

{
  xdg = {
    enable = true;
    configHome = ~/.config;
    dataHome = ~/.local/share;
    cacheHome = ~/.cache;
  };
}
