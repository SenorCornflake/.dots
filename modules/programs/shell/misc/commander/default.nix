
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.misc.commander;
in

{
  options.modules.programs.shell.misc.commander = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        commander
        python3
      ];

      xdg.configFile."commander" = {
        target = "commander/commands.json";
        recursive = false;
        source = config.configDir + "/commander/commands.json";
      };
    };
  };
}
