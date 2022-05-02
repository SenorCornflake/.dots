{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf optional;
  cfg = config.modules.hardware.bluetooth;
in
{
  options.modules.hardware.bluetooth = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
    };
  };
}
