{ config, pkgs, ... }: 

{
  services.picom = {
    enable = true;
    experimentalBackends = true;
    backend = "glx";
    inactiveDim = "0.05";
    fade = true;
    fadeSteps = [
      "0.1"
      "0.1"
    ];
    vSync = true;
    shadow = true;
    noDockShadow = false;
    shadowOffsets = [
      (-20)
      (-20)
    ];
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
  };
}
