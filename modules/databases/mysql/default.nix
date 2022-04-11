{ config, pkgs, lib, ... }:

let 
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) mkIf;
  cfg = config.modules.databases.mysql;
in
{
  options.modules.databases.mysql = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
      dataDir = "/var/lib/mysql";
    };
  };
}
