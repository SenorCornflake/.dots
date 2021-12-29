
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
    transmission-gtk
    libsForQt5.ark
    (xfce.thunar.override {
      thunarPlugins = [
        xfce.thunar-dropbox-plugin
        xfce.thunar-archive-plugin
        xfce.thunar-media-tags-plugin
        xfce.thunar-volman
      ];
    })
    lxappearance
    xorg.xcursorthemes
    redshift
    polkit_gnome
    vlc
    ytfzf
    mpv
    wmctrl
    libreoffice
    todo-txt-cli
    filezilla
    (dwarf-fortress-packages.dwarf-fortress-full.override {
      enableIntro = false;
      enableTruetype = true;
      enableFPS = true;
      enableSound = false;
      enableSoundSense = true;
      enableStoneSense = false;
      enableDwarfTherapist = false;
      theme = dwarf-fortress-packages.themes.phoebus;
    })
    whatsapp-for-linux
    (python39.withPackages (p: with p; [
      pyyaml
      pynvim
      urllib3
    ]))
    herbstluftwm
    file # for lf
    android-tools
    flameshot
    blueberry
    (inkscape-with-extensions.override {
      inkscapeExtensions = (with pkgs.inkscape-extensions; [
        inkcut
      ]);
    })
    gimp
    krita
    flavours
    zeal
    lutris
    imagemagick
 ];
}
