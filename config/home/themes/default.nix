{ ... }:
{
  polybar = {
    first = {
      bg = "#000000";
      fg = "#ffffff";

      active = "#44bb55"; occupied = "#999999"; empty = "#333333";
      title = "#ddaa00";

      disk = "#0088dd";
      total_transfer = "#cccc00";
      net = "#77bbbb";
      ram = "#44dd44";
      cpu = "#ee5599";
      cpu_temp = "#ff4400";
      bat = "#0088dd";
      vol = "#00ddaa"; muted = "#aa0000";
      backlight = "#cccc00";
      time = "#bbbbbb";
      layout = "#ee5599";
      weather = "#8888ff";
      health = "#33cc33";

      separator = "#333333";
    };

    second = {
      bg = "#000000";
      fg = "#ffffff";
      disk = "#77bbbb";
      cpu = "#cccc00";
      cpu_temp = "#ff4400";
      ram = "#ee5599";
      net = "#0088dd";
      weather = "#44dd44";
      active = "#999999";
      occupied = "#999999";
      empty = "#44dd44";
      vol = "#00ddaa";
      key_layout = "#ee5599";
      time = "#bbbbbb";
      health = "#44dd44";
      bat = "#ddaa00";
    };
  };

  rofi = {
    first = {
      bg = "#000000";
      fg = "#dddddd";
      border = "#8888ff";
      active_text = "#ddaa00";
      prompt = "#44dd44";
    };

    second = {
      bg = "#000000";
      fg = "#dddddd";
      border = "#000000";
      active_bg = "#44dd44";
      entry_bg = "#bbbbbb";
    };
  };

  dunst = {
    first = {
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
        frame_color = "#ff4400";
      };

      frame_color = "#77bbbb";
      separator_color = "#000000";
    };

    second = {
      urgency_low = {
        background = "#bbbbbb";
        foreground = "#000000";
      };

      urgency_normal = {
        background = "#bbbbbb";
        foreground = "#000000";
      };

      urgency_critical = {
        background = "#aa0000";
        foreground = "#000000";
      };

      frame_color = "#000000";
      separator_color = "#111111";
    };
  };

  neovim = {
    colorscheme = "tokyonight";
  };

  kitty = {
    colorscheme = "plain_black";
  };

  herbstluftwm = {
    first = {
      active_color = "#666666";
      normal_color = "#111111";
      urgent_color = "#aa0000";

      # These are not actuallu used for this layout
      outer_color = "#000000";
      inner_color = "#000000";
      active_title_color = "#333333";
      normal_title_color = "#000000";
    };

    second = {
      active_color = "#00ddaa";
      normal_color = "#999999";
      urgent_color = "#aa0000";
      outer_color = "#000000";
      inner_color = "#000000";
      active_title_color = "#333333";
      normal_title_color = "#000000";
    };
  };
}
