
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.dunst;
in

{
  options.modules.programs.gui.misc.dunst = {
    enable = mkBoolOpt false;
    layout = mkOpt types.str "one";

    urgencyLow = mkOpt types.attrs {
      background = "#000000";
      foreground = "#ffffff";
    };
    urgencyNormal = mkOpt types.attrs {
      background = "#000000";
      foreground = "#ffffff";
    };
    urgencyCritical = mkOpt types.attrs {
      background = "#000000";
      foreground = "#ffffff";
    };

    frameColor = mkOpt types.str "#222222";
    seperatorColor = mkOpt types.str "#333333";
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        libnotify
      ];

      services.dunst = {
        enable = true;

        settings = {
          global = {
            notification_limit = 0;
            browser = "${pkgs.firefox}/bin/firefox -new-tab";
            dmenu = "${pkgs.dunst}/bin/rofi -dmenu -p \"Dunst:\"";
            ignore_newline = "no";
            show_age_threshold = 60;
            stack_duplicates = true;
            hide_duplicate_count = false;

            frame_color = cfg.frameColor;
            separator_color = cfg.seperatorColor;
          };

          urgency_low = cfg.urgencyLow;
          urgency_normal = cfg.urgencyNormal;
          urgency_critical = cfg.urgencyCritical;
        };
      };
    };
  };
}
