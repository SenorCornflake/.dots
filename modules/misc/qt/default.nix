{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types;
  cfg = config.modules.misc.qt;
in

let 
  styles = {
    adwaita-dark = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
      platformTheme = "gnome";
    };
  };
in {
  options.modules.misc.qt = {
    enable = mkBoolOpt true;
    styles = mkOpt types.attrs styles;
    style = mkOpt types.attrs styles.adwaita-dark;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      qt = {
        enable = true;
        platformTheme = cfg.style.platformTheme;
        style = {
          name = cfg.style.name;
          package = cfg.style.package;
        };
      };
    };
  };
}
