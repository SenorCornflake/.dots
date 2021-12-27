{ config, pkgs, ... }:

{
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
}
