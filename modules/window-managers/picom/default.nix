{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf types attrValues optionalString;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) any toJSON  elemAt toString;
  cfg = config.modules.window-managers.picom;
in

{
  options.modules.window-managers.picom = {
    enable = mkBoolOpt false;
    inactiveDim = mkOpt types.str "0";
    blur = mkBoolOpt false;
    blurStrength = mkOpt types.str "5";
    blurSize = mkOpt types.str "5";
    noDockShadow = mkBoolOpt false;
    fade = mkBoolOpt true;
    shadow = mkBoolOpt true;
    shadowOpacity = mkOpt types.str "0.75";
    shadowRadius = mkOpt types.str "5";
    shadowOffsets = mkOpt (types.listOf types.str) [
      "-5"
      "-5"
    ];
    shadowExclude = mkOpt (types.listOf types.str) [
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

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      services.picom = {
        enable = true;
        package = pkgs.picom-next;
        experimentalBackends = true;
        backend = "glx";
        inactiveDim = cfg.inactiveDim;
        vSync = true;
        noDockShadow = cfg.noDockShadow;
        extraOptions = ''
          focus-exclude = [
            "class_g = 'Rofi'" # Fix inactive dim on rofi
          ];

        '' + optionalString cfg.blur ''
          blur-background = true;
          blur-method="dual_kawase";
          blur-strength=${cfg.blurStrength};
          blur-size=${cfg.blurSize};
          blur-background-fixed=true;

        '' + optionalString cfg.shadow ''
          shadow = true;
          shadow-offset-x = ${(elemAt cfg.shadowOffsets 0)};
          shadow-offset-y = ${(elemAt cfg.shadowOffsets 1)};
          shadow-opacity = ${cfg.shadowOpacity};
          shadow-exclude = ${toJSON cfg.shadowExclude};
          shadow-radius = ${cfg.shadowRadius}

        '' + optionalString cfg.fade ''
          fading = true;
          fade-delta = 5;
          fade-in-step = 0.028;
          fade-out-step = 0.03;
          fade-exclude = [];
        '';
      };
    };
  };
}
