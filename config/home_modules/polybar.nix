{ config, pkgs, ... }:
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
    };
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
      bg = "#000000";
      fg = "#ffffff";
      title = "#ddaa00";
      active = "#44bb55";
      occupied = "#999999";
      empty = "#333333";
      weather = "8888ff";
      time = "#bbbbbb";
      volume = "#00ddaa";
      muted = "#aa0000";
      battery = "#0088dd";
      separator = "#333333";
      cputemp = "#ff4400";
      ram = "#44dd44";
      cpu = "#ee5599";
      network = "#77bbbb";
      total_transfer = "#cccc00";
    in {
      "bar/main" = {
        bottom = false;
        height = 20;
        width = "100%";
        font."0" = "Terminus:size=10;2";
        modules.left = "desktops title";
        modules.right = "total_transfer sep network sep cpu sep ram sep cputemp sep battery sep volume sep time sep weather";
        background = bg;
        foreground = fg;
        monitor = "\${env:MONITOR:eDP-1}";
      };

      "bar/main-primary" = {
        "inherit" = "bar/main";
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
          text = "> = <";
          foreground = separator;
        };
      };

      "module/weather" = {
        type = "custom/script";
        exec = "${pkgs.curl}/bin/curl -s 'wttr.in?format=%f'";
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
          connected = "%essid% %upspeed% UP %downspeed% DOWN";
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
    };
  };
}




