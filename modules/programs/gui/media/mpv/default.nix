
{ inputs, config, lib, pkgs, ... }:

let 
  inherit (builtins) toString;
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.media.mpv;
in
{
  options.modules.programs.gui.media.mpv = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.mpv = {
        enable = true;
      };
    };
  };
}
