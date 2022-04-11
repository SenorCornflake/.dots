{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.shell.misc.git;
in

{
  options.modules.programs.shell.misc.git = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.git = {
        enable = true;
        userName = "Baker";
        userEmail = "cmdwannabe@gmail.com";
        extraConfig = {
          credential = {
            helper = "store";
          };
        };
      };
    };
  };
}
