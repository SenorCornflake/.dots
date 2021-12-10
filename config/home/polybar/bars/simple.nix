{ pkgs, theme }:

{
  script = ''
    PATH=$PATH:${pkgs.gnugrep}/bin:${pkgs.xorg.xrandr}/bin:${pkgs.gawk}/bin

    connected=$(xrandr --query | grep connected -w | awk '{print $1}')

    echo "$connected" | while read line; do
      if [[ $(xrandr --query | grep "$line" | grep primary) ]]; then
          MONITOR="$line" polybar bottom-primary &
          MONITOR="$line" polybar bottom &
      else
        #MONITOR="$line" polybar top &
        MONITOR="$line" polybar bottom &
      fi
    done
  '';
  settings = let
    bg = theme.polybar.simple.bg;
    fg = theme.polybar.simple.fg;

    active = theme.polybar.simple.active; occupied = theme.polybar.simple.occupied; empty = theme.polybar.simple.empty;
    title = theme.polybar.simple.title;

    disk = theme.polybar.simple.disk;
    total_transfer = theme.polybar.simple.total_transfer;
    network = theme.polybar.simple.network;
    ram = theme.polybar.simple.ram;
    cpu = theme.polybar.simple.cpu;
    cputemp = theme.polybar.simple.cputemp;
    battery = theme.polybar.simple.battery;
    volume = theme.polybar.simple.volume; muted = theme.polybar.simple.muted;
    backlight = theme.polybar.simple.backlight;
    time = theme.polybar.simple.time;
    layout = theme.polybar.simple.layout;
    weather = theme.polybar.simple.weather;
    health = theme.polybar.simple.health;

    separator = theme.polybar.simple.separator;
  in {
    "bar/bottom" = {
      bottom = true;
      height = 20;
      width = "100%";
      font."0" = "Terminus:size=10;2";
      modules.left = "desktops title";
      modules.right = "disk sep total_transfer sep network sep ram sep cpu sep cputemp sep battery sep volume sep backlight sep time sep layout sep weather sep health";
      background = bg;
      foreground = fg;
      monitor = "\${env:MONITOR:eDP-1}";
      enable-ipc = true;
    };

    "bar/bottom-primary" = {
      "inherit" = "bar/bottom";
      tray.position = "right";
      tray.detached = false;
      tray.background = bg;
      tray.padding = 0;
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
          text = "#";
          padding = 1;
          foreground = active;
        };
        occupied = {
          text = "+";
          padding = 1;
          foreground = occupied;
        };
        empty = {
          text = "-";
          padding = 1;
          foreground = empty;
        };
      };
    };

    "module/title" = {
      type = "internal/xwindow";
      label = {
        text = "%title%";
        maxlen = 30;
      };
      format = {
        text = "<label>";
        foreground = title;
        padding = 1;
      };
    };

    "module/volume" = {
      type = "internal/pulseaudio";
      sink = "alsa_output.pci-0000_00_1b.0.analog-stereo";
      interval = 5;
      click.right = "${pkgs.pavucontrol}/bin/pavucontrol &";
      label = {
        volume = "%percentage%%";
        muted = "mut";
      };
      format = {
        volume = {
          padding = 1;
          foreground = volume;
          text = "<label-volume>";
          suffix = {
            text = " V";
            foreground = volume;
          };
        };
        muted = {
          padding = 1;
          foreground = muted;
          text = "<label-muted>";
          suffix = {
            text = " V";
          };
        };
      };
    };

    "module/battery" = {
      type = "internal/battery";
      battery = "BAT0";
      adapter = "AC";
      poll-interval = "20";
      format = {
        charging = {
          text = "<label-charging>";
          padding = 1;
          foreground = battery;
          suffix = {
            text = " BC";
          };
        };
        discharging = {
          text = "<label-discharging>";
          padding = 1;
          foreground = battery;
          suffix = {
            text = " BD";
          };
        };
        full = {
          text = "<label-full>";
          padding = 1;
          foreground = battery;
          suffix = {
            text = " BF";
          };
        };
      };
      label = {
        charging = "%percentage%%";
        discharging = "%percentage%%";
        full = "%percentage%%";
      };
    };

    "module/time" = {
      type = "internal/date";
      date = "%a, %d %b %Y";
      time = "%H:%M:%S";
      label = "%time% %date%";
      format = {
        text = "<label>";
        padding = 1;
        foreground = time;
      };
    };

    "module/sep" = {
      type = "custom/text";
      content = {
        text = ":";
        foreground = separator;
      };
    };

    "module/weather" = {
      type = "custom/script";
      exec = "${pkgs.curl}/bin/curl -s 'wttr.in/Capetown?format=%f'";
      interval = 60;
      label = "%output%";
      format = {
        foreground = weather;
        padding = 1;
      };
    };

    "module/cputemp" = {
      type = "custom/script";
      # This is quite a beefy line, should probably do something about it
      exec = "echo \"$(${pkgs.lm_sensors}/bin/sensors | grep \"Core\" | ${pkgs.gnused}/bin/sed \"s/.*://\" | ${pkgs.gnused}/bin/sed \"s/(.*)//\" | ${pkgs.gnused}/bin/sed \"s/ //g\" | ${pkgs.gnused}/bin/sed \"s/°C//\" | ${pkgs.gnused}/bin/sed \"s/+//\")\" | ${pkgs.gawk}/bin/awk '{s+=$1}END{print s/NR}' RS=\"\\n\"";
      label = "%output%°C";
      interval = 5;
      format = {
        foreground = cputemp;
        padding = 1;
        suffix = " T";
      };
    };

    "module/ram" = {
      type = "internal/memory";
      interval = 5;
      format = {
        foreground = ram;
        padding = 1;
        suffix = " M";
      };
    };

    "module/cpu" = {
      type = "internal/cpu";
      interval = 5;
      format = {
        text = "<label>";
        foreground = cpu;
        suffix = " C";
        padding = 1;
      };
      label = "%percentage%%";
    };

    "module/network" = {
      type = "internal/network";
      interface = "wlp3s0";
      interval = "5";
      format = {
        connected = {
          padding = 1;
          foreground = network;
          text = "<label-connected>";
        };
        disconnected = {
          padding = 1;
          foreground = network;
          text = "<label-disconnected>";
        };
      };
      label = {
        connected = "%essid% %upspeed% ↑ %downspeed% ↓";
        disconnected = "disconnected";
      };
    };

    "module/total_transfer" = {
      type = "custom/script";
      interval = 5;
      exec = "echo $(($((`${pkgs.coreutils}/bin/cat /sys/class/net/wlp3s0/statistics/rx_bytes` + `${pkgs.coreutils}/bin/cat /sys/class/net/wlp3s0/statistics/tx_bytes`)) / 1000000))";
      format = {
        text = "<label>";
        padding = 1;
        suffix = " TT";
        foreground = total_transfer;
      };
      label = "%output%";
    };

    "module/health" = {
      type = "custom/ipc";
      hook-0 = "${pkgs.coreutils}/bin/cat $DOT_ROOT/scripts/storage/health.txt";
      initial = 1;
      format = {
        text = "<output>";
        padding = 1;
        foreground = health;
      };
    };

    "module/disk" = {
      type = "internal/fs";
      mount-0 = "/";
      format-mounted = {
        text = "<label-mounted>";
        padding = 1;
        foreground = disk;
      };
      label = {
        mounted = "%used%/%total%";
      };
    };

    "module/layout" = {
      type = "internal/xkeyboard";
      format = {
        text = "<label-layout>";
        padding = 1;
        foreground = layout;
      };
      label = {
        layout = "%name%";
      };
    };

    "module/backlight" = {
      type = "internal/backlight";
      format = {
        test = "<label>";
        foreground = backlight;
        padding = 1;
        suffix = " L";
      };
      label = "%percentage%";
      card = "intel_backlight";
    };
  };
}
