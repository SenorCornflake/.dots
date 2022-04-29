{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types;
  cfg = config.modules.misc.gtk;
in

{
  options.modules.misc.gtk = {
    enable = mkBoolOpt true;
    theme = mkOpt types.str "adwaita";
    font = mkOpt types.str "Noto Sans, 10";
  };

  config = mkIf cfg.enable {
    fonts.fonts = with pkgs; [
      noto-fonts
    ];

    home-manager.users."${config.userName}" = {
      gtk = {
        enable = true;
        font.name = cfg.font;
        gtk2.configLocation = "${config.home-manager.users."${config.userName}".xdg.configHome}/gtk-2.0/gtkrc";
      };
    };

    programs.dconf.enable = true;
  };
}
