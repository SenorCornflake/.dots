{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
  };
}
