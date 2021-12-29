{ pkgs, lib, ... }:

lib.recursiveUpdate (import ./first.nix { inherit pkgs lib; }) {
  polybar.layout = "third";
  rofi.layout = "first";
  dunst.layout = "third";
  herbstluftwm.layout = "third";

  kitty = {
    font_family = "Iosevka Nerd Font";
    font_size = "10";
    window_padding_width = "10";
  };

  picom = {
    shadow = true;
    noDockShadow = true;
    shadowRadius = "5";
    inactiveDim = "0.1";
    shadowOffsets = [
      (-5)
      (-5)
    ];
  };
}
