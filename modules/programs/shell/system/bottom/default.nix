
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.system.bottom;
in

{
  options.modules.programs.shell.system.bottom = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.bottom = {
        enable = true;
      };
    };
  };
}
