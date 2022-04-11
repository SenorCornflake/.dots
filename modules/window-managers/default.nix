{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf attrValues;
  inherit (builtins) any;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.window-managers;
in {
  config = mkIf
    (any (v: v.enable) (attrValues cfg))
    {
      home-manager.users."${config.userName}" = {
        home.packages = with pkgs; [
          redshift
        ];
      };
    };
}
