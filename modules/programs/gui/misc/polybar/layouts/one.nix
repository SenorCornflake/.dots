
{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types recursiveUpdate;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.polybar;

  scheme = recursiveUpdate 
    {
      bg = "#111111";
      fg = "#aaaaaa";
      border = "#000000";
      active = "#00ff00";
      accent = "#00ffff";
      title = "#773377";
    }
    cfg.scheme;
in

{
  config = mkMerge [
    (mkIf (cfg.layout == "one") {
      fonts.fonts = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "Iosevka"
          ];
        })
        terminus_font
      ];

      home-manager.users."${config.userName}" = {
        services.polybar = {
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
          settings = {
            "bar/main" = {
              bottom = true;
              height = 30;
              width = "100%";
              background = scheme.bg;
              foreground = scheme.fg;
              font."0" = "Terminus:size=10;2";
              monitor = "\${env:MONITOR:eDP-1}";
              enable-ipc = true;
              modules.left = "desktops title";
              modules.center = "time";
              modules.right = "vol ram cpu cpu_temp bat";
              border-top-color = scheme.border;
              border-top-size = 1;
            };

            "bar/main-primary" = {
              "inherit" = "bar/main";
              tray.position = "right";
              tray.detached = false;
              tray.background = scheme.bg;
              tray.padding = 2;
            };

            "module/desktops" = {
              type = "internal/xworkspaces";
              pin.workspaces = false;
              format = {
                text = "<label-state>";
              };
              label = {
                active = {
                  text = "%name%";
                  padding = 2;
                  foreground = scheme.active;
                  background = scheme.bg;
                };
                occupied = {
                  text = "%name%";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                };
                empty = {
                  text = "-";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                };
              };
            };

            "module/time" = {
              type = "internal/date";
              date = "%a, %d %b %Y";
              time = "%H:%M:%S";
              label = "%time% %date%";
              format = {
                text = "<label>";
                padding = 2;
                foreground = scheme.fg;
                background = scheme.bg;
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
                foreground = scheme.title;
                background = scheme.bg;
                padding = 3;
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
              format = {
                volume = {
                  padding = 2;
                  background = scheme.bg;
                  foreground = scheme.fg;
                  text = "<label-volume>";
                  prefix = {
                    text = "VOL";
                    foreground = scheme.accent;
                    padding = 1;
                  };
                };
                muted = {
                  padding = 2;
                  background = scheme.bg;
                  foreground = scheme.fg;
                  text = "<label-muted>";
                  prefix = {
                    text = "VOL";
                    foreground = scheme.accent;
                    padding = 1;
                  };
                };
              };
            };

            "module/ram" = {
              type = "internal/memory";
              interval = 5;
              format = {
                foreground = scheme.fg;
                background = scheme.bg;
                padding = 2;
                prefix = {
                  text = "RAM";
                  foreground = scheme.accent;
                  padding = 1;
                };
              };
            };

            "module/cpu" = {
              type = "internal/cpu";
              interval = 5;
              format = {
                text = "<label>";
                foreground = scheme.fg;
                background = scheme.bg;
                prefix = {
                  text = "CPU";
                  foreground = scheme.accent;
                  padding = 1;
                };
                padding = 2;
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
                padding = 1;
                prefix = {
                  text = "TEMP";
                  foreground = scheme.accent;
                  padding = 1;
                };
              };
            };

            "module/bat" = {
              type = "internal/battery";
              bat = "BAT0";
              adapter = "AC";
              poll-interval = "20";
              format = {
                charging = {
                  text = "<label-charging>";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                  prefix = {
                    text = "BAT";
                    foreground = scheme.accent;
                    padding = 1;
                  };
                };
                discharging = {
                  text = "<label-discharging>";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                  prefix = {
                    text = "BAT";
                    foreground = scheme.accent;
                    padding = 1;
                  };
                };
                full = {
                  text = "<label-full>";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                  prefix = {
                    text = "BAT";
                    foreground = scheme.accent;
                    padding = 1;
                  };
                };
              };
              label = {
                charging = "%percentage%%";
                discharging = "%percentage%%";
                full = "%percentage%%";
              };
            };
          };
        };
      };
    })
  ];
}
