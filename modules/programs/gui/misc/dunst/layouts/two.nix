
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.dunst;
in

{
  config = mkIf (cfg.layout == "two") {
    fonts.fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "Iosevka"
        ];
      })
    ];

    home-manager.users."${config.userName}" = {
      services.dunst.settings = {
        global = {
          height = 300;
          width = "(0, 400)";
          origin = "top-right";
          offset = "15x70";
          frame_width = 3;
          separator_height = 2;
          font = "Iosevka Nerd Font 10";
          padding = 15;
          horizontal_padding = 15;
          alignment = "left";
          word_wrap = "yes";
          icon_position = "left";
          format = "<b>[%a] %s</b>\\n%b\\n\\n%p";
          line_height = 2;
        };
      };
    };
  };
}
