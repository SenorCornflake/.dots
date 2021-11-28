{ config, pkgs, ... }:

{
  networking = {
    hostName = "slab";
    wireless.enable = false;
    networkmanager.enable = true;

    interfaces = {
      enp0s25.useDHCP = false;
      wlp3s0.useDHCP = true;
      wwp0s20u10i6.useDHCP = true;
    };
  };
}
