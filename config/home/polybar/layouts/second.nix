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
    s = style.polybar.second;
  in {
    "bar/main" = {
      bottom = false;
      height = 25;
      width = "100%";
      font."0" = "Iosevka Nerd Font:size=10;2";
      font."1" = "Iosevka Nerd Font:size=8;2";
      modules.left = "disk sep cpu sep cpu_temp sep ram sep net sep weather";
      modules.center = "desktops";
      modules.right = "vol sep key_layout sep time sep health sep bat";
      background = s.bg;
      foreground = s.fg;
      monitor = "\${env:MONITOR:eDP-1}";
      enable-ipc = true;
      border-size = 6;
      border-color = s.bg;
    };

    "bar/main-primary" = {
      "inherit" = "bar/main";
      tray.position = "right";
      tray.detached = false;
      tray.background = s.bg;
      tray.padding = 2;
    };

    "module/disk" = {
      type = "internal/fs";
      mount-0 = "/";
      format-mounted = {
        text = "<label-mounted>";
        padding = 1;
        foreground = s.bg;
        background = s.disk;
        prefix = {
          text = "  ";
        };
      };
      label = {
        mounted = "%used%/%total%";
      };
    };

    "module/cpu" = {
      type = "internal/cpu";
      interval = 5;
      format = {
        text = "<label>";
        foreground = s.bg;
        background = s.cpu;
        prefix = "  ";
        padding = 1;
      };
      label = "%percentage%%";
    };

    "module/cpu_temp" = {
      type = "custom/script";
      # This is quite a beefy line, should probably do something about it
      exec = "echo \"$(${pkgs.lm_sensors}/bin/sensors | grep \"Core\" | ${pkgs.gnused}/bin/sed \"s/.*://\" | ${pkgs.gnused}/bin/sed \"s/(.*)//\" | ${pkgs.gnused}/bin/sed \"s/ //g\" | ${pkgs.gnused}/bin/sed \"s/°C//\" | ${pkgs.gnused}/bin/sed \"s/+//\")\" | ${pkgs.gawk}/bin/awk '{s+=$1}END{print s/NR}' RS=\"\\n\"";
      label = "%output%°C";
      interval = 5;
      format = {
        foreground = s.bg;
        background = s.cpu_temp;
        padding = 1;
        prefix = "  ";
      };
    };

    "module/ram" = {
      type = "internal/memory";
      interval = 5;
      format = {
        foreground = s.bg;
        background = s.ram;
        padding = 1;
        prefix = {
          text = "  ";
        };
      };
    };

    "module/net" = {
      type = "internal/network";
      interface = "wlp3s0";
      interval = "5";
      format = {
        connected = {
          padding = 1;
          foreground = s.bg;
          background = s.net;
          text = "<label-connected>";
        };
        disconnected = {
          padding = 1;
          foreground = s.bg;
          background = s.net;
          text = "<label-disconnected>";
        };
      };
      label = {
        connected = "%upspeed%   %downspeed%  ";
        disconnected = "disconnected";
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
          text = "";
          padding = 1;
          foreground = s.active;
        };
        occupied = {
          text = "";
          padding = 1;
          foreground = s.occupied;
        };
        empty = {
          text = "";
          padding = 1;
          foreground = s.empty;
        };
      };
    };

    "module/weather" = {
      type = "custom/script";
      exec = "${pkgs.curl}/bin/curl -s \"wttr.in/$(echo \"$(${pkgs.curl}/bin/curl -s https://ipinfo.io/)\" | ${pkgs.jq}/bin/jq -r '.city' | ${pkgs.gnused}/bin/sed 's/ /+/g')?format=%f+%C\"";
      interval = 60;
      label = "%output%";
      format = {
        background = s.weather;
        foreground = s.bg;
        prefix = "  ";
        padding = 1;
      };
    };

    "module/vol" = {
      type = "internal/pulseaudio";
      sink = "alsa_output.pci-0000_00_1b.0.analog-stereo";
      interval = 5;
      click.right = "${pkgs.pavucontrol}/bin/pavucontrol &";
      label = {
        volume = "%percentage%%";
        muted = "";
      };
      ramp-volume = {
        "0" = "";
        "1" = "";
        "2" = "";
      };
      format = {
        volume = {
          padding = 1;
          background = s.vol;
          foreground = s.bg;
          text = "<ramp-volume>  <label-volume>";
        };
        muted = {
          padding = 1;
          background = s.vol;
          foreground = s.bg;
          text = " <label-muted>";
        };
      };
    };

    "module/key_layout" = {
      type = "internal/xkeyboard";
      format = {
        text = "<label-layout>";
        padding = 1;
        foreground = s.bg;
        background = s.key_layout;
        prefix = "  ";
      };
      label = {
        layout = "%name%";
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
        foreground = s.bg;
        background = s.time;
        prefix = "  ";
      };
    };

    "module/health" = {
      type = "custom/ipc";
      hook-0 = "${pkgs.coreutils}/bin/cat $DOT_ROOT/scripts/storage/health.txt";
      initial = 1;
      format = {
        text = "<output>";
        padding = 1;
        foreground = s.bg;
        background = s.health;
        prefix = "  ";
      };
    };

    "module/bat" = {
      type = "internal/battery";
      bat = "BAT0";
      adapter = "AC";
      poll-interval = "20";
      ramp-capacity = {
        "0" = "";
        "1" = "";
        "2" = "";
        "3" = "";
      };
      format = {
        charging = {
          text = "<ramp-capacity>  <label-charging> ";
          padding = 1;
          foreground = s.bg;
          background = s.bat;
        };
        discharging = {
          text = "<ramp-capacity>  <label-discharging>";
          padding = 1;
          foreground = s.bg;
          background = s.bat;
        };
        full = {
          text = "<ramp-capacity>  <label-full>";
          padding = 1;
          foreground = s.bg;
          background = s.bat;
        };
      };
      label = {
        charging = "%percentage%%";
        discharging = "%percentage%%";
        full = "%percentage%%";
      };
    };

    "module/sep" = {
      type = "custom/text";
      content = " ";
      content-font = "2";
    };
  };
}
