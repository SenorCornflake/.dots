
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf recursiveUpdate types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.desktop-environments.gnome;
in

{
  options = {
    modules.desktop-environments.gnome = {
      enable = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}".home.packages = with pkgs; [
      gnome.gnome-tweaks
    ];

    services.xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
    };
  };
}
