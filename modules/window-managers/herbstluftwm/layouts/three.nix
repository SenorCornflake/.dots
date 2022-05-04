{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.window-managers.herbstluftwm;
in

{
  config = mkIf (cfg.layout == "three") {
    modules = {
      window-managers = {
        herbstluftwm = {
          settings = {
            window_gap = "15";
          };
          attributes = {
            "theme.border_width" = "0";
            "theme.title_height" = "5";
          };
        };
      };
    };
  };
}
