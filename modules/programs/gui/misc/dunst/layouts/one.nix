
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.dunst;
in

{
  config = mkIf cfg.enable {
    fonts.fonts = with pkgs; [
      terminus_font
    ];

    home-manager.users."${config.userName}" = {
      services.dunst.settings = {
        global = {
          height = 300;
          width = "(0, 400)";
          origin = "bottom-right";
          offset = "10x40";
          frame_width = 1;
          separator_height = 1;
          font = "Terminus 10";
          padding = 10;
          horizontal_padding = 10;
          alignment = "left";
          word_wrap = "yes";
          icon_position = "left";
          format = "%a :: %s\\n\\n%b\\n\\n%p";
          line_height = 2;
        };
      };
    };
  };
}
