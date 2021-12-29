{ pkgs, style, ... }:

{
  script = ''
    PATH=$PATH:${pkgs.gnugrep}/bin:${pkgs.xorg.xrandr}/bin:${pkgs.gawk}/bin

    connected=$(xrandr --query | grep connected -w | awk '{print $1}')

    echo "$connected" | while read line; do
      if [[ $(xrandr --query | grep "$line" | grep primary) ]]; then
          MONITOR="$line" polybar main-primary &
      else
        MONITOR="$line" polybar main &
      fi
    done
  '';

  settings = let
    inherit (style.polybar.third) bg fg active occupied; 
  in
  {
    "bar/main" = {
      bottom = false;
      height = 20;
      width = "100%";
      font."0" = "Terminus:size=10;2";
      font."1" = "Siji:size=8;2";
      modules.left = "time";
      modules.center = "desktops";
      modules.right = "cpu ram cpu_temp vol";
      background = bg;
      foreground = fg;
      monitor = "\${env:MONITOR:eDP-1}";
      enable-ipc = true;
      border-size = 6;
      border-color = bg;
    };

    "bar/main-primary" = {
      "inherit" = "bar/main";
      tray.position = "left";
      tray.detached = false;
      tray.background = bg;
      tray.padding = 2;
    };

    "module/time" = {
      type = "internal/date";
      date = "%a, %d %b %Y";
      time = "%H:%M:%S";
      label = "%time% %date%";
      format = {
        text = "<label>";
        padding = 2;
        foreground = fg;
        background = bg;
        prefix = " ";
      };
    };

    "module/desktops" = {
      type = "internal/xworkspaces";
      pin.workspaces = false;
      format = {
        text = "<label-state>";
        padding = 1;
      };
      label = {
        active = {
          text = "";
          padding = 1;
          foreground = active;
        };
        occupied = {
          text = "";
          padding = 1;
          foreground = occupied;
        };
        empty = {
          text = "";
          padding = 1;
          foreground = fg;
        };
      };
    };

    "module/cpu" = {
      type = "internal/cpu";
      interval = 5;
      format = {
        text = "<label>";
        foreground = fg;
        background = bg;
        prefix = " ";
        padding = 2;
      };
      label = "%percentage%%";
    };

    "module/cpu_temp" = {
      type = "custom/script";
      # This is quite a beefy line, should probably do something about it
      exec = "echo \"$(${pkgs.lm_sensors}/bin/sensors | ${pkgs.gnugrep}/bin/grep \"Core\" | ${pkgs.gnused}/bin/sed \"s/.*://\" | ${pkgs.gnused}/bin/sed \"s/(.*)//\" | ${pkgs.gnused}/bin/sed \"s/ //g\" | ${pkgs.gnused}/bin/sed \"s/°C//\" | ${pkgs.gnused}/bin/sed \"s/+//\")\" | ${pkgs.gawk}/bin/awk '{s+=$1}END{print s/NR}' RS=\"\\n\"";
      label = "%output%°C";
      interval = 5;
      format = {
        foreground = fg;
        background = bg;
        padding = 2;
        prefix = " ";
      };
    };

    "module/ram" = {
      type = "internal/memory";
      interval = 5;
      format = {
        foreground = fg;
        background = bg;
        padding = 2;
        prefix = {
          text = " ";
        };
      };
    };

    "module/vol" = {
      type = "internal/pulseaudio";
      sink = "alsa_output.pci-0000_00_1b.0.analog-stereo";
      interval = 5;
      click.right = "${pkgs.pavucontrol}/bin/pavucontrol &";
      label = {
        volume = "%percentage%%";
        muted = "x";
      };
      ramp-volume = {
        "0" = "";
        "1" = "";
        "2" = "";
        "3" = "";
      };
      format = {
        volume = {
          padding = 2;
          background = bg;
          foreground = fg;
          text = "<ramp-volume>  <label-volume>";
        };
        muted = {
          padding = 2;
          background = bg;
          foreground = fg;
          text = " <label-muted>";
        };
      };
    };
  };

}
