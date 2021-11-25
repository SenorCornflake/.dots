{ config, pkgs, ...}:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        geometry = "300x15-30-50";
        frame_color = "#00ffff";
        frame_width = 2;
        separator_height = 2;
        separator_color = "#111111";
        font = "Iosevka Nerd Font 10";
        padding = 10;
        horizontal_padding = 10;
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p \"Dunst:\"";
        ignore_newline = "no";
        show_age_threshold = 60;
        format = "<b>%a >> %s</b>\\n%b\\n%p";
        alignment = "left";
        word_wrap = "yes";
        stack_duplicates = true;
        hide_duplicate_count = false;
        icon_position = "left";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#ffffff";
      };

      urgency_normal = {
        background = "#000000";
        foreground = "#ffffff";
      };

      urgency_critical = {
        background = "#000000";
        foreground = "#ffffff";
      };

      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+shift+grave";
        context = "ctrl+shift+period";
      };
    };
  };
}
