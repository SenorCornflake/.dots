{ pkgs, lib, ... }:

lib.recursiveUpdate (import ./first.nix { inherit pkgs lib; }) {
  polybar.layout = "second";
  rofi.layout = "second";
  dunst.layout = "second";
  herbstluftwm.layout = "second";
}
