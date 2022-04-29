{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types;
  cfg = config.modules.misc.qt;
in

{
  options.modules.misc.qt = {
    enable = mkBoolOpt true;
    theme = mkOpt types.str "adwaita";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      qt = {
        enable = true;
      };
    };
  };
}
