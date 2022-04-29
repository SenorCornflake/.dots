{ config, pkgs, lib, ... }:

let
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types;
  cfg = config.modules.misc.gtk;
in

mkIf (cfg.theme == "adwaita") {
  home-manager.users."${config.userName}" = {
    gtk = {
      enable = true;

      cursorTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome.adwaita-icon-theme;
      };

      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome.adwaita-icon-theme;
      };
    };
  };
}
