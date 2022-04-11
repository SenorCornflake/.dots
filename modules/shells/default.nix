

{ inputs, config, lib, pkgs, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.shell;
in
{
  options.modules.shell = mkOpt types.str "zsh";
}
