
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    brightnessctl
    pulseaudio-ctl
    pavucontrol
    feh
    neofetch
    macchina
    git
    python39
    psmisc
    transmission-gtk
    libsForQt5.ark
    unrar
    unzip
    (xfce.thunar.override {
      thunarPlugins = [
        xfce.thunar-dropbox-plugin
        xfce.thunar-archive-plugin
        xfce.thunar-media-tags-plugin
      ];
    })
    xfce.thunar-volman
    gparted
    lxappearance
    xorg.xcursorthemes
    redshift
    libnotify
    lm_sensors
    polkit_gnome
    xkbset
    vlc
    ytfzf
    mpv
    trash-cli
    bat
    wmctrl
    libreoffice
    todo-txt-cli
    bottom
    any-nix-shell
    filezilla
    (dwarf-fortress-packages.dwarf-fortress-full.override {
      enableIntro = false;
      enableTruetype = true;
      enableFPS = true;
      enableSound = false;
      theme = dwarf-fortress-packages.themes.meph;
    })
    whatsapp-for-linux
  ];
}
