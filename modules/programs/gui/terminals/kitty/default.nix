
{ config, lib, pkgs, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.terminals.kitty;
in

{
  options.modules.programs.gui.terminals.kitty = {
    enable = mkBoolOpt false;
    fontFamily = mkOpt types.str "monospace";
    fontSize = mkOpt types.int 10;
    windowPaddingWidth = mkOpt types.str "0";
    backgroundOpacity = mkOpt types.float 1.0;
    colorScheme = mkOpt types.str "";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.kitty = {
        enable = true;
        extraConfig = ''
          font_family ${cfg.fontFamily}
          bold_font auto
          italic_font auto
          bold_italic_font auto

          font_size ${toString cfg.fontSize}

          adjust_line_height 100%
          adjust_column_width 100%
          adjust_baseline 1
          disable_ligatures yes

          scrollback_lines 50000
          cursor_blink_interval 0
          enable_audio_bell no

          window_padding_width ${cfg.windowPaddingWidth}

          ${cfg.colorScheme}

          background_opacity ${toString cfg.backgroundOpacity}
        '';
      };
    };
  };
}
