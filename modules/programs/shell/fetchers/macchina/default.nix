{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.fetchers.macchina;
in

{
  options.modules.programs.shell.fetchers.macchina = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.programs.shell.fetchers.fetchCommand = "macchina";

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
