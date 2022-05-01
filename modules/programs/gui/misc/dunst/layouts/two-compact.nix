
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.dunst;
in

{
  config = mkIf (cfg.layout == "two-compact") {
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
          offset = "15x32";
          frame_width = 2;
          separator_height = 2;
          font = "Iosevka Nerd Font 10";
          padding = 10;
          horizontal_padding = 10;
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
