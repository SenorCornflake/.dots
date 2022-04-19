{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.gui.graphics.inkscape;
in
{
  options.modules.programs.gui.graphics.inkscape = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        (inkscape-with-extensions.override {
          inkscapeExtensions = (with inkscape-extensions; [
            inkcut
          ]);
        })
      ];
    };
  };
}
