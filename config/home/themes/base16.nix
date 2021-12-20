{ pkgs, lib, ... }:
let
  b = (builtins.fromJSON (builtins.readFile ../../../scripts/storage/base16.json));
in lib.recursiveUpdate (import ./default.nix { inherit pkgs lib; }) {
  polybar = {
    bar = "first";

    first = {
      bg = b.base00;
      fg = b.base07;

      active = b.base0B; occupied = b.base03; empty = b.base01;
      title = b.base0A;

      disk = b.base0C;
      total_transfer = b.base0D;
      network = b.base0F;
      ram = b.base0B;
      cpu = b.base0E;
      cputemp = b.base0F;
      battery = b.base0C;
      volume = b.base08; muted = b.base09;
      backlight = b.base0A;
      time = b.base07;
      layout = b.base0C;
      weather = b.base0D;
      health = b.base0B;

      separator = b.base01;
    };

    second = {
      bg = "#" + b.base00;
      fg = "#" + b.base07;
      disk = "#" + b.base0C;
      cpu = "#" + b.base0A;
      cpu_temp = "#" + b.base09;
      ram = "#" + b.base0E;
      net = "#" + b.base0D;
      weather = "#" + b.base0B;
      active = "#" + b.base08;
      occupied = "#" + b.base08;
      empty = "#" + b.base0B;
      vol = "#" + b.base0E;
      key_layout = "#" + b.base0C;
      time = "#" + b.base04;
      health = "#" + b.base0B;
      bat = "#" + b.base0A;
    };
  };

  rofi = {
    layout = "first";
    first = {
      bg = "#" + b.base00;
      fg = "#" + b.base06;
      border = "#" + b.base0C;
      active_text = "#" + b.base0F;
      prompt = "#" + b.base0B;
    };

    second = {
      bg = "#" + b.base00;
      fg = "#" + b.base07;
      border = "#" + b.base00;
      active_bg = "#" + b.base0B;
      entry_bg = "#" + b.base07;
    };
  };

  dunst = {
    layout = "first";

    first = {
      urgency_low = {
        background = "#" + b.base00;
        foreground = "#" + b.base07;
      };

      urgency_normal = {
        background = "#" + b.base00;
        foreground = "#" + b.base07;
      };

      urgency_critical = {
        background = "#" + b.base00;
        foreground = "#" + b.base07;
        frame_color = "#" + b.base09;
      };

      frame_color = "#"+ b.base0A;
      separator_color = "#" + b.base02;
    };

    second = {
      urgency_low = {
        background = "#" + b.base07;
        foreground = "#" + b.base00;
      };

      urgency_normal = {
        background = "#" + b.base07;
        foreground = "#" + b.base00;
      };

      urgency_critical = {
        background = "#" + b.base09;
        foreground = "#" + b.base00;
      };

      frame_color = "#"+ b.base00;
      separator_color = "#" + b.base00;
    };
  };

  neovim = {
    colorscheme = "catppuccin";
  };

  kitty = {
    colorscheme = "generated";
  };

  herbstluftwm = {
    first = {
      active_color = "#" + b.base07;
      normal_color = "#" + b.base01;
      urgent_color = "#" + b.base09;
    };

    second = {
      active_color = "#" + b.base04;
      normal_color = "#" + b.base01;
      urgent_color = "#" + b.base09;
      outer_color = "#" + b.base00;
      inner_color = "#" + b.base00;
      active_title_color = "#" + b.base00;
      normal_title_color = "#" + b.base06;
    };
  };
}
