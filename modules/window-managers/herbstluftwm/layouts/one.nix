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
        herbstluftwm = {
          settings = {
            window_gap = "10";
          };
          attributes = {
            "theme.border_width" = "1";
          };
        };
      };
    };
  };
}
