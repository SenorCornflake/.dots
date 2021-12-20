{ config, pkgs, ... }:

{
  networking = {
    hostName = "t440p";
    wireless.enable = false;
    networkmanager.enable = true;

    interfaces = {
      wlp3s0.useDHCP = true;
      wwp0s20u10i6.useDHCP = true;
    };
  };

  /* systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false; */
}
