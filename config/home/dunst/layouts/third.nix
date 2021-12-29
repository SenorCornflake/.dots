{ config, pkgs, lib, style, ... }:

{
  global = {
    height = 300;
    width = "(0, 400)";
    origin = "top-left";
    offset = "10x40";
    notification_limit = 0;
    frame_color = style.dunst.third.frame_color;
    frame_width = 0;
    separator_height = 0;
    separator_color = style.dunst.third.separator_color;
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

  urgency_low = style.dunst.third.urgency_low;
  urgency_normal = style.dunst.third.urgency_normal;
  urgency_critical = style.dunst.third.urgency_critical;
}
