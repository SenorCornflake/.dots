{ ... }:

{
  polybar.layout = "first";
  rofi.layout = "first";
  dunst.layout = "first";
  herbstluftwm.layout = "first";

  kitty = {
    font_family = "Iosevka Nerd Font";
    font_size = "10";
    window_padding_width = "0";
    background_opacity = "1.0";
  };

  wezterm = {
    font = "Iosevka Nerd Font";
    font_size = "10.0";
    window_padding = {
      top = "0px";
      right = "0px";
      bottom = "0px";
      left = "0px";
    };
  };

  picom = {
    shadow = true;
    noDockShadow = false;
    shadowRadius = "15";
    blur = false;
    inactiveDim = "0.05";
    shadowOffsets = [
      (-15)
      (-15)
    ];
  };
}
