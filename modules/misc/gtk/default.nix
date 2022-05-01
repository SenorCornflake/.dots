{ config, lib, pkgs, ... }:

let
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) types;

  cfg = config.modules.misc.gtk;
in
{
  options.modules.misc.gtk = {
    theme = mkOpt types.str "Adwaita-dark";
    iconTheme = mkOpt types.str "Adwaita";
    cursorTheme = mkOpt types.str "Adwaita";
    font = mkOpt types.str "Noto Sans, 10";
  };

  config = {
    fonts.fonts = with pkgs; [
      noto-fonts
    ];

    home-manager.users."${config.userName}" = {
      gtk = {
        enable = true;
        font.name = cfg.font;
        gtk2.configLocation = "${config.configHome}/gtk-2.0/gtkrc";
      };
    };
  };
}
