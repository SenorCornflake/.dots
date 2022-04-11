{ config, pkgs, lib, ... }:

let
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.kernel;
in
{
  options = {
    modules.kernel = {
      useLatestKernel = mkBoolOpt false;
    };
  };

  config = {
    boot.kernelPackages = (if cfg.useLatestKernel then pkgs.linuxPackages_latest else pkgs.linuxPackages);
  };
}
