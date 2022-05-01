{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf;
  cfg = config.modules.networking.networkmanager;
in
{
  options.modules.networking.networkmanager = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      wireless.enable = false;
      firewall.enable = false;
    };
  };
}
