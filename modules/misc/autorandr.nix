{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf types any attrValues;
  cfg = config.modules.misc.autorandr;
in

{
  options.modules.misc.autorandr = {
    enable = mkBoolOpt false;
    profiles = mkOpt types.attrs {};
  };

  config = mkIf (cfg.enable || (any (v: v.enable) (attrValues config.modules.window-managers))) {
    home-manager.users."${config.userName}" = {
      programs.autorandr = {
        enable = true;
        profiles = cfg.profiles;
      };
    };
  };
}
