{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    unrar
    unzip
    gparted
    libnotify
    xkbset
    trash-cli
    any-nix-shell
    bottom
    ntfs3g
    jq # used in herbstluftwm config
    bc
    bat
    psmisc
    lm_sensors
  ];
}
