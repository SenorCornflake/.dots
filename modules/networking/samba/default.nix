{ config, lib, pkgs, ... }:

let
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) types mkIf mapAttrs;

  cfg = config.modules.networking.samba;
in
{
  options.modules.networking.samba = {
    enable = mkBoolOpt false;
    openDirs = mkOpt types.attrs {};
  };

  config = mkIf cfg.enable {
    services.samba = {
      enable = true;
      shares = (mapAttrs
        (n: v:
          {
            path = v;
            browseable = "yes";
            "read only" = "no";
            "guest ok" = "yes";
            "create mask" = "0644";
            "directory mask" = "0755";
          })
        (cfg.openDirs));
      extraConfig = ''
        browseable = yes
      '';
    };
  };
}
