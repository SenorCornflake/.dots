{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.misc.macchina;
in

{
  options.modules.programs.shell.misc.macchina = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        macchina
      ];

      xdg.configFile."macchina" = {
        recursive = true;
        target = "macchina";
        source = config.configDir + "/macchina";
      };
    };
  };
}
