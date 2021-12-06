{
  polybar = {
    simple = {
      bg = "#000000";
      fg = "#ffffff";

      active = "#44bb55"; occupied = "#999999"; empty = "#333333";
      title = "#ddaa00";

      disk = "#0088dd";
      total_transfer = "#cccc00";
      network = "#77bbbb";
      ram = "#44dd44";
      cpu = "#ee5599";
      cputemp = "#ff4400";
      battery = "#0088dd";
      volume = "#00ddaa"; muted = "#aa0000";
      backlight = "#cccc00";
      time = "#bbbbbb";
      layout = "#ee5599";
      weather = "8888ff";
      health = "#33cc33";

      separator = "#333333";
    };
  };

  rofi = {
    bg = "#000000";
    fg = "#dddddd";
    border = "#8888ff";
    active_text = "#ddaa00";
    prompt = "#44dd44";
  };

  dunst = {
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
      frame_color = "#aa0000";
    };

    frame_color = "#77bbbb";
    separator_color = "#111111";
  };
}
