{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types recursiveUpdate;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.terminals;
in

{
  options.modules.programs.gui.terminals = {
    default = mkOpt types.str "xterm";
  };
}
