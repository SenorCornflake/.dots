{ config, lib, pkgs, ... }:

let
  inherit (lib) mkMerge mkIf;
  cfg = config.modules.misc.qt;
in
{
  config = {
    home-manager.users."${config.userName}" = {
      qt = mkMerge [
        (mkIf (cfg.theme == "adwaita" || cfg.theme == "adwaita-dark") {
          style = {
            name = cfg.theme;
            package = pkgs.adwaita-qt;
          };
          platformTheme = "gnome";
        })
      ];
    };
  };
}
