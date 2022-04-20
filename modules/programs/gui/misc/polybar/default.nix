{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types attrValues;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) any;
  cfg = config.modules.programs.gui.misc.polybar;
in

{
  options.modules.programs.gui.misc.polybar = {
    enable = mkBoolOpt false;
    layout = mkOpt types.str "one";
    scheme = mkOpt types.attrs {};
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
