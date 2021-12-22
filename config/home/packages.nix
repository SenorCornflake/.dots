
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
    brightnessctl
    pulseaudio-ctl
    pavucontrol
    feh
    macchina
    git
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
      theme = dwarf-fortress-packages.themes.phoebus;
    })
    whatsapp-for-linux
    bc
    (python39.withPackages (p: with p; [
      pyyaml
      pynvim
    ]))
    herbstluftwm
    file # for lf
    android-tools
    #lutris
    flameshot
    blueberry
    jq # used in herbstluftwm config
    gimp
    inkscape
    krita
    flavours
    zeal
  ];
}
