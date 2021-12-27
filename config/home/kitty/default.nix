{ config, pkgs, style, ... }:

let 
  colorscheme = import (./. + "/colors/${style.kitty.colorscheme}.nix");
in {
  programs.kitty = {
    enable = true;
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

      scrollback_lines 50000
      cursor_blink_interval 0
      enable_audio_bell no

      window_padding_width 0

      ${colorscheme}
    '';
  };
}
