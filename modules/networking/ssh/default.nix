{ config, lib, pkgs, ... }:

let
  inherit (lib) types mkIf;
  inherit (lib.my) mkOpt mkBoolOpt;
  cfg = config.modules.networking.ssh;
in

{
  options.modules.networking.ssh = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}
