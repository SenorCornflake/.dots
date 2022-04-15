{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.shell.fetchers;
in

{
  options.modules.programs.shell.fetchers = {
    fetchCommand = mkOpt types.str "";
  };
}
