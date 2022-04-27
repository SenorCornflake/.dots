
{ config, lib, pkgs, ... }:

let 
# TODO: Don't hardcode the system specific values, like in battery and pulseaudio
  inherit (lib) mkIf mkMerge types recursiveUpdate optionalString imap0;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (builtins) listToAttrs;
  cfg = config.modules.programs.gui.misc.polybar;

  hlwm_enabled = config.modules.window-managers.herbstluftwm.enable;

  scheme = recursiveUpdate 
    {
      bg = "#111111";
      fg = "#ffffff";
      decor = "#333333";
      icons = "#aaaaff";
      empty = "#444444";
      urgent = "#ff0000";
      other = "#00ff00";
      indicators = "#00aaaa";
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
in

{
  config = mkMerge [
    (mkIf (cfg.layout == "two") {
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
                  MONITOR="$line" polybar main-primary &
              else
                MONITOR="$line" polybar main &
              fi
            done
          '';
          settings = {
            "bar/main" = {
              bottom = false;
              height = 40;
              width = "100%:-30";
              offset-x = "15px";
              offset-y = "15px";
              background = scheme.bg;
              foreground = scheme.fg;
              border-size = 3;
              border-color = scheme.decor;
              monitor = "\${env:MONITOR:eDP-1}";
              enable-ipc = true;
              modules.left = 
                "nightmode sep time sep"
                + (optionalString hlwm_enabled " hlwm_mode sep hlwm_layout");
              modules.center = "desktops";
              modules.right = "sep vol brightness net bat";
              font = {
                "0" = "Iosevka Nerd Font:size=10:weight=bold;3";
                "1" = "Material Design Icons:size=12;2";
              };
            };

            "bar/main-primary" = {
              "inherit" = "bar/main";
              tray.position = "left";
              tray.detached = false;
              tray.background = scheme.bg;
              tray.padding = 2;
            };

            "module/time" = {
              type = "internal/date";
              date = "%H:%M:%S";
              date-alt = "%a, %d %b %Y";
              label = "%date%";
              format = {
                text = "<label>";
                padding = 2;
                foreground = scheme.fg;
                background = scheme.bg;
                prefix = {
                  padding = 1;
                  text = "󰅐";
                  foreground = scheme.icons;
                };
              };
            };

            "module/sep" = {
              type = "custom/text";
              content = {
                text = "󰧞";
                foreground = scheme.decor;
                padding = 0;
              };
            };

            "module/desktops" = {
              type = "internal/xworkspaces";
              pin.workspaces = false;
              format = {
                text = "<label-state>";
              };
              label = {
                active = {
                  text = "󰐾";
                  padding = 1;
                  foreground = scheme.other;
                  background = scheme.bg;
                };
                occupied = {
                  text = "󰄯";
                  padding = 1;
                  foreground = scheme.other;
                  background = scheme.bg;
                };
                empty = {
                  text = "󰄰";
                  padding = 1;
                  foreground = scheme.empty;
                  background = scheme.bg;
                };
                urgent = {
                  text = "󰀨";
                  padding = 1;
                  foreground = scheme.urgent;
                  background = scheme.bg;
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
                muted = "%percentage%%";
              };
              ramp.volume = mkRamp ["󰕿" "󰖀" "󰕾"] scheme.icons;
              format = {
                volume = {
                  padding = 2;
                  background = scheme.bg;
                  foreground = scheme.fg;
                  text = "<ramp-volume> <label-volume>";
                };
                muted = {
                  padding = 2;
                  background = scheme.bg;
                  foreground = scheme.fg;
                  text = "<label-muted>";
                  prefix = {
                    text = "󰖁 ";
                    foreground = scheme.icons;
                  };
                };
              };
            };

            "module/net" = {
              type = "internal/network";
              interface = "wlp3s0";
              interval = 2;
              ramp.signal = mkRamp ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"] scheme.icons;
              format = {
                connected = {
                  text = "<ramp-signal> <label-connected>";
                  padding = 2;
                };
                disconnected = {
                  text = "<label-disconnected>";
                  padding = 2;
                  prefix = {
                    text = "󰤭 ";
                    foreground = scheme.icons;
                  };
                };
              };

              label = {
                connected = "%essid:0:20:...% 󰓢 %netspeed%";
                disconnected = "none";
              };
            };

            "module/bat" = {
              type = "internal/battery";
              bat = "BAT0";
              adapter = "AC";
              poll-interval = "10";
              ramp.capacity = mkRamp ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"] scheme.icons;
              format = {
                charging = {
                  text = "<ramp-capacity> <label-charging>";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                };
                discharging = {
                  text = "<ramp-capacity> <label-discharging>";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                };
                full = {
                  text = "<label-full>";
                  padding = 2;
                  foreground = scheme.fg;
                  background = scheme.bg;
                  prefix = {
                    text = "󱟠 ";
                    foreground = scheme.icons;
                  };
                };
              };
              label = {
                charging = "%percentage%% 󱐌";
                discharging = "%percentage%%";
                full = "%percentage%%";
              };
            };

            "module/brightness" = {
              type = "internal/backlight";
              card = "intel_backlight";
              enable-scroll = true;
              ramp = mkRamp ["󰃞" "󰃟" "󰃠"] scheme.icons;
              format = {
                text = "<ramp> <label>";
                padding = 2;
              };
              label = "%percentage%%";
            };

            "module/hlwm_mode" = {
              type = "custom/script";
              tail = true;
              exec = "${cfg.scripts.herbstluftwm-mode}/bin/polybar-herbstluftwm-mode 󰄶 󰝘 ";
              format = {
                text = "<label>";
                padding = 2;
                foreground = scheme.indicators;
              };
              click-left = "${pkgs.herbstluftwm}/bin/herbstclient floating toggle";
            };

            "module/hlwm_layout" = {
              type = "custom/script";
              tail = true;
              exec = "${cfg.scripts.herbstluftwm-layout}/bin/polybar-herbstluftwm-layout 󰕳 󰿯 󰕶 󰜩 ";
              format = {
                text = "<label>";
                foreground = scheme.indicators;
                padding = 2;
              };
              click-left = "${pkgs.herbstluftwm}/bin/herbstclient cycle_layout +1";
            };

            # TODO: Make this script tailable
            "module/nightmode" = {
              type = "custom/script";
              tail = false;
              interval = 3;
              exec = "${cfg.scripts.nightmode}/bin/polybar-nightmode 󱠩 󱁞 ";
              format = {
                text = "<label>";
                foreground = scheme.indicators;
                padding = 2;
              };
              click-left = "${config.scripts.toggle_nightmode}/bin/toggle_nightmode";
            };
          };
        };
      };
    })
  ];
}
