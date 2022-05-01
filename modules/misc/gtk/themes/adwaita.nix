{ config, lib, pkgs, ... }:

let
  inherit (lib) mkMerge mkIf;
  cfg = config.modules.misc.gtk;
in
{
  config = {
    home-manager.users."${config.userName}" = {
      gtk = mkMerge [
        (mkIf (cfg.theme == "Adwaita" || cfg.theme == "Adwaita-dark") {
          theme = {
            name = cfg.theme;
            package = pkgs.gnome.gnome-themes-extra;
          };
        })

        (mkIf (cfg.iconTheme == "Adwaita") {
          iconTheme = {
            name = cfg.iconTheme;
            package = pkgs.gnome.adwaita-icon-theme;
          };
        })

        (mkIf (cfg.cursorTheme == "Adwaita") {
          cursorTheme = {
            name = cfg.cursorTheme;
            package = pkgs.gnome.adwaita-icon-theme;
          };
        })
      ];
    };
  };
}
