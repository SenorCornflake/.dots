{ pkgs, lib, ... }:

lib.recursiveUpdate (import ./first.nix { inherit pkgs lib; }) {
  polybar.layout = "second";
  rofi.layout = "second";
  dunst.layout = "second";
  herbstluftwm.layout = "second";

  kitty = {
    font_family = "Iosevka Nerd Font";
    font_size = "10";
    window_padding_width = "10";
  };
}
