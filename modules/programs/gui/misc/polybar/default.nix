{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types attrValues;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) any;
  cfg = config.modules.programs.gui.misc.polybar;

  mkScript = name: deps: (pkgs.writeShellScriptBin
    "polybar-${name}"
    ''
      PATH=${lib.makeBinPath deps}
      ${builtins.readFile (config.dotsDir + "/config/polybar/scripts/${name}.sh")}
    '');
in

{
  options.modules.programs.gui.misc.polybar = {
    enable = mkBoolOpt false;
    layout = mkOpt types.str "one";
    scheme = mkOpt types.attrs {};
    scripts = mkOpt types.attrs {
      herbstluftwm-layout = mkScript "herbstluftwm-layout" (with pkgs; [ gnugrep herbstluftwm ]);
      herbstluftwm-mode = mkScript "herbstluftwm-mode" (with pkgs; [ gnugrep herbstluftwm ]);
      temp = mkScript "temp" (with pkgs; [ gnugrep gnused lm_sensors gawk ]);
      nightmode = mkScript "nightmode" (with pkgs; [ libnotify inotify-tools coreutils ]);
    };
  };

  config = mkIf (cfg.enable && (any (v: v.enable) (attrValues config.modules.window-managers))) {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        pavucontrol
        lm_sensors
      ];

      services.polybar = {
        enable = true;
        package = pkgs.polybar.override {
          alsaSupport = true;
          pulseSupport = true;
        };
      };
    };
  };
}
