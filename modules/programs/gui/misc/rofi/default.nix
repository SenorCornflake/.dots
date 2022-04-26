
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.rofi;
in

{
  options.modules.programs.gui.misc.rofi = {
    enable = mkBoolOpt false;
    scheme = mkOpt types.attrs {};
    layout = mkOpt types.str "one";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.rofi = {
        enable = true;
      };
    };


  };
}
