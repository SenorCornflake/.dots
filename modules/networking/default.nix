
{ config, pkgs, lib, ... }:

let
  inherit (lib) types mkIf;
  inherit (lib.my) mkOpt mkBoolOpt;
in
{
  options.modules.networking = {
    interface = mkOpt types.str "wlan0";
  };
}
