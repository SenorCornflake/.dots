
{ config, pkgs, style, lib, ...}:

{
  services.dunst = {
    enable = true;
    settings = (import (./. + "/layouts/${style.dunst.layout}.nix")) { inherit config pkgs style lib; };
  };
}
