{ config, lib, ... }: 

let
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (lib) types mkIf;

  cfg = config.modules.misc.grub;
in
{
  options.modules.misc.grub = {
    enable = mkBoolOpt true;
    useOSProber = mkBoolOpt true;
    devices = mkOpt (types.listOf types.str) [ "/dev/sda" ];
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        grub = {
          enable = true;
          devices = cfg.devices;
          useOSProber = cfg.useOSProber;
          version = 2;
        };
      };
    };
  };
}
