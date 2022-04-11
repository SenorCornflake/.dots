
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.misc.exa;
in

{
  options.modules.programs.shell.misc.exa = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.exa = {
        enable = true;
        enableAliases = false;
      };
    };
  };
}
