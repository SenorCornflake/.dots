# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    ./bootloader.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./sound.nix
    ./users.nix
    ./webserver.nix
    ./hardware.nix
  ];

  nix = {
     package = pkgs.nixUnstable;
     autoOptimiseStore = true;
     extraOptions = ''
      keep-outputs = false
      keep-derivations = false
     '' +
     (lib.optionalString (config.nix.package == pkgs.nixUnstable) "experimental-features = nix-command flakes");
  };

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
