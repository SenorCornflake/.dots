{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.gui.file-managers.thunar;
in

{
  options.modules.programs.gui.file-managers.thunar = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        (xfce.thunar.override {
          thunarPlugins = [
            xfce.thunar-dropbox-plugin
            xfce.thunar-archive-plugin
            xfce.thunar-media-tags-plugin
            xfce.thunar-volman
          ];
        })
        ntfs3g
        gvfs
      ];
    };

    services.gvfs.enable = true;
  };
}
