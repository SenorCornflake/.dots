{ config, pkgs, theme, ...}:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        height = 300;
        width = "(0, 400)";
        origin = "bottom-right";
        offset = "10x30";
        notification_limit = 0;
        frame_color = theme.dunst.frame_color;
        frame_width = 2;
        separator_height = 2;
        separator_color = theme.dunst.separator_color;
        font = "Iosevka Nerd Font 10";
        padding = 10;
        horizontal_padding = 10;
        browser = "${pkgs.firefox}/bin/firefox -new-tab";
        dmenu = "${pkgs.dunst}/bin/rofi -dmenu -p \"Dunst:\"";
        ignore_newline = "no";
        show_age_threshold = 60;
        format = "<b>%a >> %s</b>\\n%b\\n%p";
        alignment = "left";
        word_wrap = "yes";
        stack_duplicates = true;
        hide_duplicate_count = false;
        icon_position = "left";
      };

      urgency_low = theme.dunst.urgency_low;
      urgency_normal = theme.dunst.urgency_normal;
      urgency_critical = theme.dunst.urgency_critical;
    };
  };
}
