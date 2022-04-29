
{ config, pkgs, lib, ... }:

let
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types;
  cfg = config.modules.misc.qt;
in

mkIf (cfg.theme == "adwaita") {
  home-manager.users."${config.userName}" ={
    qt = {
      platformTheme = "gnome";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
