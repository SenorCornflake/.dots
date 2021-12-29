{ pkgs, lib, ... }:

lib.recursiveUpdate (import ./default.nix { inherit pkgs lib; }) {
  polybar = {
    first = {
      bg = "#1E1E29";
      fg = "#D7DAE0";

      active = "#E28C8C"; occupied = "#6E6C7C"; empty = "#3E4058";
      title = "#A4B9EF";

      disk = "#B3E1A3";
      total_transfer = "#EADDA0";
      net = "#C6AAE8";
      ram = "#D7DAE0";
      cpu = "#B3E1A3";
      cpu_temp = "#E28C8C";
      bat = "#A4B9EF";
      vol = "#F0AFE1"; muted = "#E28C8C";
      backlight = "#EADDA0";
      time = "#D7DAE0";
      layout = "#F0AFE1";
      weather = "#C6AAE8";
      health = "#B3E1A3";

      separator = "#3E4058";
    };

    third = {
      bg = "#1E1E29";
      fg = "#D7DAE0";
      active = "#F0AFE1";
      occupied = "#C6AAE8";
    };
  };

  rofi = {
    first = {
      bg = "#1E1E29";
      fg = "#6E6C7C";
      border = "#B3E1A3";
      active_text = "#A4B9EF";
      prompt = "#C6AAE8";
    };

    second = {
      bg = "#1E1E29";
      fg = "#6E6C7C";
      border = "#1E1E29";
      active_bg = "#EADDA0";
      entry_bg = "#1E1E29";
    };
  };

  dunst = {
    first = {
      urgency_low = {
        background = "#1E1E29";
        foreground = "#D7DAE0";
      };

      urgency_normal = {
        background = "#1E1E29";
        foreground = "#D7DAE0";
      };

      urgency_critical = {
        background = "#1E1E29";
        foreground = "#D7DAE0";
        frame_color = "#E28C8C";
      };

      frame_color = "#A4B9EF";
      separator_color = "#3E4058";
    };

    third = {
      urgency_low = {
        background = "#1E1E29";
        foreground = "#D7DAE0";
      };

      urgency_normal = {
        background = "#1E1E29";
        foreground = "#D7DAE0";
      };

      urgency_critical = {
        background = "#1E1E29";
        foreground = "#D7DAE0";
        frame_color = "#E28C8C";
      };

      frame_color = "#A4B9EF";
      separator_color = "#3E4058";
    };
  };

  neovim = {
    colorscheme = "catppuccin";
  };

  kitty = {
    colorscheme = "catppuccin";
  };

  herbstluftwm = {
    first = {
      active_color = "#6E6C7C";
      normal_color = "#3E4058";
      urgent_color = "#E28C8C";

      # These are not actuallu used for this layout
      outer_color = "#000000";
      inner_color = "#000000";
      active_title_color = "#333333";
      normal_title_color = "#000000";
    };

    second = {
      active_color = "#6E6C7C";
      normal_color = "#3E4058";
      urgent_color = "#E28C8C";
      outer_color = "#3E4058";
      inner_color = "#3E4058";
      active_title_color = "#3E4058";
      normal_title_color = "#D7DAE0";
    };

    third = {
      # None of these are used
      active_color = "#D7DAE0";
      normal_color = "#555555";
      urgent_color = "#E28C8C";
      outer_color = "#000000";
      inner_color = "#000000";
      active_title_color = "#3E4058";
      normal_title_color = "#D7DAE0";
    };
  };

  wallpaper = {
    solid = {
      bg = "#1E1E29";
    };
  };
}

