{ pkgs, lib, ... }:

lib.recursiveUpdate (import ./first.nix { inherit pkgs lib; }) {
  polybar.layout = "third";
  rofi.layout = "third";
  dunst.layout = "third";
  herbstluftwm.layout = "third";

  kitty = {
    font_family = "Iosevka Nerd Font";
    font_size = "10";
    window_padding_width = "10";
    background_opacity = "1";
  };

  wezterm = {
    font = "Iosevka Nerd Font";
    font_size = "10";
    window_padding = {
      top = "10px";
      right = "10px";
      bottom = "10px";
      left = "10px";
    };
  };

  picom = {
    shadow = true;
    noDockShadow = false;
    shadowRadius = "5";
    inactiveDim = "0.1";
    blur = false;
    shadowOffsets = [
      (-5)
      (-5)
    ];
  };
}
