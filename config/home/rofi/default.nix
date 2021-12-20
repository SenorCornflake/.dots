{ config, pkgs, style, ... }:

{
  programs.rofi = {
    enable = true;
  } // ( import (./. + "/layouts/${style.rofi.layout}.nix") { inherit config pkgs style; } );
}
