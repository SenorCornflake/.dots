{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.gui.browsers.firefox;
in
{
  options.modules.programs.gui.browsers.firefox = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      programs.firefox = {
        enable = true;
        profiles = {
          myprofile = {
            settings = {
              "general.autoScroll" = true;
              "general.smoothScroll" = true;
            };
          };
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          bitwarden
          ublock-origin
          h264ify
        ];
      };
    };
  };
}
