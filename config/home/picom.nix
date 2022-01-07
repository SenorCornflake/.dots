{ config, pkgs, pkgs-unstable, style, ... }: 

{
  services.picom = {
    enable = true;
    package = pkgs.picom-next;
    experimentalBackends = true;
    backend = "glx";
    # TODO: Inactive dim affects rofi, try to fix
    inactiveDim = style.picom.inactiveDim;
    fade = true;
    fadeSteps = [
      "0.1"
      "0.1"
    ];
    vSync = true;
    shadow = style.picom.shadow;
    blur = style.picom.blur;
    noDockShadow = style.picom.noDockShadow;
    shadowOffsets = style.picom.shadowOffsets;
    shadowExclude = [
      "! name~=''"
      "name = 'Notification'"
      "name = 'Plank'"
      "name = 'Docky'"
      "name = 'Kupfer'"
      "name = 'xfce4-notifyd'"
      "name *= 'compton'"
      "name *= 'picom'"
      "class_g = 'firefox' && argb"
      "class_g = 'Conky'"
      "class_g = 'Kupfer'"
      "class_g = 'Synapse'"
      "class_g ?= 'Notify-osd'"
      "class_g ?= 'Cairo-dock'"
      "class_g ?= 'Xfce4-notifyd'"
      "class_g ?= 'Xfce4-power-manager'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    ];
    extraOptions = ''
      shadow-radius = ${style.picom.shadowRadius}
      blur-method="dual_kawase";
      blur-strengh=10;
      blur-background-fixed=true;
    '';
  };
}
