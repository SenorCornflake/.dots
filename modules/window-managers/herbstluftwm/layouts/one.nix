{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types mkMerge;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.window-managers.herbstluftwm;
in

{
  config = mkIf (cfg.layout == "one") {
    modules = {
      window-managers = {
        herbstluftwm.settings = {
          border_width = "1";
          window_gap = "10";
        };
      };
    };
  };
}
