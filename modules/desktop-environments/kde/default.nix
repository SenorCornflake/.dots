
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf recursiveUpdate types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.desktop-environments.kde;
in

{
  options = {
    modules.desktop-environments.kde = {
      enable = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
  };
}
