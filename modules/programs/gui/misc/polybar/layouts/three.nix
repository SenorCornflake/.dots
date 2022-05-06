{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types recursiveUpdate optionalString imap0;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) listToAttrs;
  cfg = config.modules.programs.gui.misc.polybar;

  hlwm_enabled = config.modules.window-managers.herbstluftwm.enable;

  scheme = recursiveUpdate 
    {
      bg = "#50000000";
      fg = "#ffffff";
      module-bg = "#000000";
      empty = "#777777";
      accent = "#aaffaa";
      sep = "#444444";
    }
    cfg.scheme;

  mkRamp = icons: foreground: 
    listToAttrs
      (imap0
        (i: v: 
          {
            name = toString i;
            value = { text = v; foreground = foreground; };
        })
        icons
      );

    interface = config.modules.network_interface;
in

{
  config = mkMerge [
    (mkIf (cfg.layout == "three") {
      fonts.fonts = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "Iosevka"
          ];
        })
      ];

      home-manager.users."${config.userName}" = {
        services.polybar = {
          script = ''
            PATH=$PATH:${pkgs.gnugrep}/bin:${pkgs.xorg.xrandr}/bin:${pkgs.gawk}/bin

            connected=$(xrandr --query | grep connected -w | awk '{print $1}')

            echo "$connected" | while read line; do
              if [[ $(xrandr --query | grep "$line" | grep primary) ]]; then
                  MONITOR="$line" polybar top &
                  MONITOR="$line" polybar bottom-primary &
              else
                MONITOR="$line" polybar top &
                MONITOR="$line" polybar bottom &
              fi
            done
          '';
          settings = {
            "bar/top" = {
              bottom = false;
              height = 25;
              width = "100%";
              background = scheme.bg;
              foreground = scheme.fg;
              monitor = "\${env:MONITOR:eDP-1}";
              enable-ipc = true;
              modules.left = "desktops sep time sep title spacer right";
              modules.center = "";
              modules.right = "left spacer vol sep bat sep keyboard_layout sep essid spacer";
              font = {
                "0" = "Iosevka Nerd Font:size=10:weight=bold;3";
                "1" = "Iosevka Nerd Font:size=14;3";
                "2" = "Material Design Icons:size=12;2";
              };
            };

            "bar/bottom" = {
              "inherit" = "bar/top";
              bottom = true;
              modules.left = "spacer nightmode sep hlwm_mode sep hlwm_layout sep hlwm_monitor spacer right";
              modules.center = "";
              modules.right = "left spacer ram sep cpu sep netspeed sep disk spacer";
            };

            "bar/bottom-primary" = {
              "inherit" = "bar/bottom";
              tray.position = "right";
              tray.detached = false;
              tray.background = scheme.module-bg;
              tray.padding = 2;
            };

            "module/left" = {
              type = "custom/text";
              content = {
                text = "";
                background = scheme.bg;
                foreground = scheme.module-bg;
                font = 2;
                margin = 0;
              };
            };

            "module/right" = {
              type = "custom/text";
              content = {
                text = "";
                background = scheme.bg;
                foreground = scheme.module-bg;
                font = 2;
                margin = 0;
              };
            };

            "module/sep" = {
              type = "custom/text";
              content = {
                text = "  |  ";
                foreground = scheme.sep;
                background = scheme.module-bg;
              };
            };

            "module/spacer" = {
              type = "custom/text";
              content = {
                text = " ";
                background = scheme.module-bg;
              };
            };

            "module/desktops" = {
              type = "internal/xworkspaces";
              pin.workspaces = false;
              format = {
                text = "<label-state>";
                background = scheme.module-bg;
              };
              label = {
                active = {
                  text = "%name%";
                  padding = 1;
                  foreground = scheme.module-bg;
                  background = scheme.accent;
                };
                occupied = {
                  text = "%name%";
                  padding = 1;
                  foreground = scheme.accent;
                  background = scheme.module-bg;
                };
                empty = {
                  text = "%name%";
                  padding = 1;
                  foreground = scheme.empty;
                  background = scheme.module-bg;
                };
                urgent = {
                  text = "%name%";
                  padding = 1;
                  foreground = scheme.accent;
                  background = scheme.module-bg;
                };
              };
            };

            "module/time" = {
              type = "internal/date";
              date = "%H:%M:%S";
              date-alt = "%a, %d %b %Y";
              label = "%date%";
              format = {
                text = "<label>";
                foreground = scheme.fg;
                padding = 0;
                background = scheme.module-bg;
              };
            };

            "module/title" = {
              type = "internal/xwindow";
              format = {
                text = "<label>";
                padding = 0;
                background = scheme.module-bg;
              };
              label-maxlen = 30;
            };

            "module/vol" = {
              type = "internal/pulseaudio";
              sink = "alsa_output.pci-0000_00_1b.0.analog-stereo";
              interval = 5;
              click.right = "${pkgs.pavucontrol}/bin/pavucontrol &";
              label = {
                volume = "%percentage%%";
                muted = "%percentage%%";
              };
              ramp.volume = mkRamp ["󰕿" "󰖀" "󰕾"] scheme.accent;
              format = {
                volume = {
                  padding = 0;
                  background = scheme.module-bg;
                  foreground = scheme.fg;
                  text = "<ramp-volume> <label-volume>";
                };
                muted = {
                  padding = 0;
                  background = scheme.module-bg;
                  foreground = scheme.fg;
                  text = "<label-muted>";
                  prefix = {
                    text = "󰖁 ";
                    foreground = scheme.accent;
                  };
                };
              };
            };

            "module/bat" = {
              type = "internal/battery";
              bat = "BAT0";
              adapter = "AC";
              poll-interval = "10";
              ramp.capacity = mkRamp ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"] scheme.accent;
              format = {
                charging = {
                  text = "<ramp-capacity> <label-charging>";
                  padding = 0;
                  foreground = scheme.fg;
                  background = scheme.module-bg;
                };
                discharging = {
                  text = "<ramp-capacity> <label-discharging>";
                  padding = 0;
                  foreground = scheme.fg;
                  background = scheme.module-bg;
                };
                full = {
                  text = "<label-full>";
                  padding = 0;
                  foreground = scheme.fg;
                  background = scheme.module-bg;
                  prefix = {
                    text = "󱟠 ";
                    foreground = scheme.accent;
                  };
                };
              };
              label = {
                charging = "%percentage%% 󱐌";
                discharging = "%percentage%%";
                full = "%percentage%%";
              };
            };

            "module/keyboard_layout" = {
              type = "internal/xkeyboard";
              format = {
                text = "<label-layout>";
                background = scheme.module-bg;
                foreground = scheme.fg;
                padding = 0;
                prefix = {
                  text = "󰌌 ";
                  foreground = scheme.accent;
                };
              };
              label = {
                layout = "%name%";
              };
              click-left = "${config.scripts.keyboard_layout}/bin/keyboard_layout";
            };

            "module/essid" = {
              type = "internal/network";
              interface = interface;
              interval = 2;
              ramp.signal = mkRamp ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"] scheme.accent;
              format = {
                connected = {
                  text = "<ramp-signal> <label-connected>";
                  padding = 0;
                  background = scheme.module-bg;
                };
                disconnected = {
                  text = "<label-disconnected>";
                  padding = 0;
                  background = scheme.module-bg;
                  prefix = {
                    text = "󰤭 ";
                    foreground = scheme.accent;
                    background = scheme.module-bg;
                  };
                };
              };

              label = {
                connected = "%essid:0:20:...%";
                disconnected = "none";
              };
            };

            "module/hlwm_mode" = {
              type = "custom/script";
              tail = true;
              exec = "${cfg.scripts.herbstluftwm-mode}/bin/polybar-herbstluftwm-mode floating tiling";
              format = {
                text = "<label>";
                padding = 0;
                foreground = scheme.accent;
                background = scheme.module-bg;
              };
              click-left = "${pkgs.herbstluftwm}/bin/herbstclient floating toggle";
            };

            "module/hlwm_layout" = {
              type = "custom/script";
              tail = true;
              exec = "${cfg.scripts.herbstluftwm-layout}/bin/polybar-herbstluftwm-layout grid max horizontal vertical";
              format = {
                text = "<label>";
                foreground = scheme.accent;
                background = scheme.module-bg;
                padding = 0;
              };
              click-left = "${pkgs.herbstluftwm}/bin/herbstclient cycle_layout +1";
            };

           "module/ram" = {
             type = "internal/memory";
             interval = 5;
             format = {
               foreground = scheme.fg;
               background = scheme.module-bg;
               padding = 0;
               prefix = {
                 text = "󰘚 ";
                 foreground = scheme.accent;
                 padding = 0;
               };
             };
           };

           "module/cpu" = {
             type = "internal/cpu";
             interval = 5;
             format = {
               text = "<label>";
               foreground = scheme.fg;
               background = scheme.module-bg;
               prefix = {
                 text = "󰍛 ";
                 foreground = scheme.accent;
                 padding = 0;
               };
               padding = 0;
             };
             label = "%percentage%%";
           };

            "module/netspeed" = {
              type = "internal/network";
              interface = interface;
              interval = 2;
              format = {
                connected = {
                  text = "<label-connected>";
                  padding = 0;
                  background = scheme.module-bg;
                  prefix = {
                    text = "󰓢 ";
                    foreground = scheme.accent;
                  };
                };
                disconnected = {
                  text = "<label-disconnected>";
                  padding = 0;
                  background = scheme.module-bg;
                  prefix = {
                    text = "󰓢 ";
                    foreground = scheme.accent;
                  };
                };
              };

              label = {
                connected = "%upspeed% %downspeed%";
                disconnected = "disconnected";
              };
            };

           "module/disk" = {
             type = "internal/fs";
             interval = 5;
             fixed-values = true;
             spacing = 0;
             mount-0 = "/";
             label.mounted = "%percentage_used%%";
             format-mounted = {
               foreground = scheme.fg;
               background = scheme.module-bg;
               padding = 0;
               text = "<label-mounted>";
               prefix = {
                 text = "󰋊 ";
                 foreground = scheme.accent;
                 padding = 0;
               };
             };
           };

            "module/nightmode" = {
              type = "custom/script";
              tail = true;
              exec = "${cfg.scripts.nightmode}/bin/polybar-nightmode 󱠩 󱁞 ";
              format = {
                text = "<label>";
                foreground = scheme.accent;
                background = scheme.module-bg;
                padding = 0;
              };
              click-left = "${config.scripts.toggle_nightmode}/bin/toggle_nightmode";
            };

            "module/hlwm_monitor" = {
              type = "custom/script";
              tail = true;
              exec = "${cfg.scripts.herbstluftwm-monitor}/bin/polybar-herbstluftwm-monitor";
              format = {
                text = "<label>";
                padding = 0;
                foreground = scheme.accent;
                background = scheme.module-bg;
              };
            };
          };
        };
      };
    })
  ];
}
