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
      network = "#C6AAE8";
      ram = "#D7DAE0";
      cpu = "#B3E1A3";
      cputemp = "#E28C8C";
      battery = "#A4B9EF";
      volume = "#F0AFE1"; muted = "#E28C8C";
      backlight = "#EADDA0";
      time = "#D7DAE0";
      layout = "#F0AFE1";
      weather = "#C6AAE8";
      health = "#B3E1A3";

      separator = "#3E4058";
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
  };

  neovim = {
    colorscheme = "catppuccin";
  };

  kitty = {
    colorscheme = "catppuccin";
  };

  herbstluftwm = {
    active_color = "#6E6C7C";
    normal_color = "#3E4058";
    urgent_color = "#E28C8C";
  };
}

