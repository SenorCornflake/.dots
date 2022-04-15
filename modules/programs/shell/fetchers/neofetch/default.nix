{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.fetchers.neofetch;
in

{
  options.modules.programs.shell.fetchers.neofetch = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    modules.programs.shell.fetchers.fetchCommand = "neofetch";

    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        neofetch
      ];
    };
  };
}
