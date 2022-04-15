
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.system.btop;
in

{
  options.modules.programs.shell.system.btop = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = [
        pkgs.btop
      ];
    };
  };
}
