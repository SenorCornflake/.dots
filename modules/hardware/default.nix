{ config, pkgs, lib, ... }:

let
  inherit (lib) types mkIf;
  inherit (lib.my) mkOpt mkBoolOpt;
in
{
  options.modules.hardware = {
      has_opengl = mkBoolOpt true;
  };
}
