{ config, pkgs, lib, ... }:

let
  inherit (lib.my) mkOpt mkBoolOpt;
  inherit (lib) types mkIf;
  cfg = config.modules.programs.gui.terminals.xterm;
in
{
  options.modules.programs.gui.terminals.xterm = {
    enable = mkBoolOpt false;
    font = mkOpt types.str "Iosevka Nerd Font Mono";
    font-size = mkOpt types.str "9";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        xterm
      ];

      xresources.properties = {
        "XTerm*faceName" = cfg.font;
        "XTerm*faceSize" = cfg.font-size;
        "XTerm*utf8" = "1";
        "XTerm*termName" = "xterm-256color";
        "XTerm*translations" = ''
          #override \
            Shift Ctrl <Key> C: copy-selection(CLIPBOARD) \n\
            Shift Ctrl <Key> V: insert-selection(CLIPBOARD)
        '';
      };
    };
  };
}
