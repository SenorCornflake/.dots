{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = (if builtins.pathExists /etc/NIXOS then true else false);
    extraConfig = ''
      font_family Iosevka Nerd Font
      bold_font auto
      italic_font auto
      bold_italic_font auto

      font_size 10

      adjust_line_height 100%
      adjust_column_width 100%
      adjust_baseline 1
      disable_ligatures never

      scrollback_lines 2000
      cursor_blink_interval 0
      enable_audio_bell no

      window_padding_width 0

      # COLORSCHEME
      foreground #dddddd
      background #000000

      selection_foreground #000000
      selection_background #fffacd

      color0 #000000
      color8 #767676

      #: black

      color1 #cc0403
      color9 #f2201f

      #: red

      color2  #19cb00
      color10 #23fd00

      #: green

      color3  #cecb00
      color11 #fffd00

      #: yellow

      color4  #0d73cc
      color12 #1a8fff

      #: blue

      color5  #cb1ed1
      color13 #fd28ff

      #: magenta

      color6  #0dcdcd
      color14 #14ffff

      #: cyan

      color7  #dddddd
      color15 #ffffff

      #: white

      mark1_foreground black
      mark1_background #98d3cb

      mark2_foreground black
      mark2_background #f2dcd3

      mark3_foreground black
      mark3_background #f274bc

      # /COLORSCHEME
    '';
  };
}
