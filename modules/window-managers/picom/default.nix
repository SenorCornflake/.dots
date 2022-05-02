{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf types attrValues;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) any;
  cfg = config.modules.window-managers.picom;
in

{
  options.modules.window-managers.picom = {
    enable = mkBoolOpt false;
    inactiveDim = mkOpt types.str "0";
    shadowOffsets = mkOpt (types.listOf types.int) [
      (-5)
      (-5)
    ];
    shadowRadius = mkOpt types.str "5";
    blur = mkBoolOpt false;
    noDockShadow = mkBoolOpt false;
    shadow = mkBoolOpt true;
    shadowOpacity = mkOpt types.str "0.75";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      services.picom = {
        enable = true;
        package = pkgs.picom-next;
        experimentalBackends = true;
        backend = "glx";
        inactiveDim = cfg.inactiveDim;
        fade = true;
        fadeSteps = [
          "0.1"
          "0.1"
        ];
        vSync = true;
        shadow = cfg.shadow;
        blur = cfg.blur;
        noDockShadow = cfg.noDockShadow;
        shadowOffsets = cfg.shadowOffsets;
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
          shadow-radius = ${cfg.shadowRadius};
          shadow-opacity = ${cfg.shadowOpacity};
          blur-method="dual_kawase";
          blur-strengh=10;
          blur-background-fixed=true;
          focus-exclude = [
            "class_g = 'Rofi'" # Fix inactive dim on rofi
          ];
          corner-radius = 0;
          round-borders = 0;
        '';
      };
    };
  };
}
