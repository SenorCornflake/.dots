# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
     package = pkgs.nixUnstable;
     extraOptions = ''
      keep-outputs = false
      keep-derivations = false
     '' +
     (lib.optionalString (config.nix.package == pkgs.nixUnstable) "experimental-features = nix-command flakes");
  };

  networking = {
    hostName = "slab";
    wireless.enable = false;
    networkmanager.enable = true;

    interfaces = {
      enp0s25.useDHCP = true;
      wlp3s0.useDHCP = true;
      wwp0s20u10i6.useDHCP = true;
    };
  };

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      displayManager.startx.enable = true;
      windowManager.herbstluftwm = {
        enable = true;
      };
    };

    gvfs = {
      enable = true;
    };

    gnome = {
      glib-networking = {
        enable = true;
      };
    };
  };

  security = {
    # This doesn't seem to do anything
    polkit = {
      enable = true;
    };
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  programs.zsh.enable = true;

  programs.dconf = {
    enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
