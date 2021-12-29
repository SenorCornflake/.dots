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
  };

  picom = {
    shadow = true;
    noDockShadow = false;
    shadowRadius = "15";
    inactiveDim = "0.05";
    shadowOffsets = [
      (-15)
      (-15)
    ];
  };
}
