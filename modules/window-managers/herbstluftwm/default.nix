{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf recursiveUpdate types;
  inherit (lib.my) mkBoolOpt mkOpt;
  inherit (pkgs) writeText;
  inherit (builtins) toJSON;
  cfg = config.modules.window-managers.herbstluftwm;
  
  settings = recursiveUpdate
    {
      # Layout related
      border_width = "1";
      title_height = "0";
      title_font = "Terminus:size=10:style=bold";
      padding_top = "0";
      padding_bottom = "0";
      padding_right = "0";
      padding_left = "0";
      outer_width = "0";
      inner_width = "0";
      window_gap = "15";

      # Scheme related
      active_color = "#000000";
      normal_color = "#000000";
      urgent_color = "#000000";
      outer_color = "#000000";
      inner_color = "#000000";
      active_title_color = "#000000";
      normal_title_color = "#000000";
    }
    cfg.settings;
in

{
  options = {
    modules.window-managers.herbstluftwm = {
      enable = mkBoolOpt false;
      settings = mkOpt types.attrs {};
    };
  };

  config = mkIf cfg.enable {
    modules.programs.shell.misc.commander.enable = true;

    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        herbstluftwm
        jq
        pulseaudio-ctl
        brightnessctl
        libnotify
        xkbset
      ];

      programs.autorandr = {
        hooks = {
          postswitch = {
            restart-wm = ''
              herbstclient reload
            '';
          };
        };
      };

      home.file = {
        "autostart" = {
          text = builtins.readFile (config.configDir + "/herbstluftwm/autostart");
          target = ".config/herbstluftwm/autostart";
          executable = true;
        };

        "rules" = {
          text = builtins.readFile (config.configDir + "/herbstluftwm/rules");
          target = ".config/herbstluftwm/rules";
          executable = true;
        };

        "keybindings" = {
          text = builtins.readFile (config.configDir + "/herbstluftwm/keybindings");
          target = ".config/herbstluftwm/keybindings";
          executable = true;
        };

        "settings" = {
          text = builtins.readFile (config.configDir + "/herbstluftwm/settings");
          target = ".config/herbstluftwm/settings";
          executable = true;
        };
      };

      xdg.dataFile."herbstluftwm-settings" = {
        target = "herbstluftwm/settings.json";
        source = writeText "herbstluftwm_settings" (toJSON config.modules.window-managers.herbstluftwm.settings);
        recursive = false;
      };

      xdg.configFile."xinit/xinitrc" = {
        text = ''
          if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
              eval $(dbus-launch --exit-with-session --sh-syntax)
          fi
          systemctl --user import-environment DISPLAY XAUTHORITY DOT_ROOT

          if command -v dbus-update-activation-environment >/dev/null 2>&1; then
              dbus-update-activation-environment DISPLAY XAUTHORITY DOT_ROOT
          fi

          touch "$XDG_DATA_HOME/herbstluftwm/first_start.txt"

          exec herbstluftwm --locked
        '';
        executable = true;
        target = "xinit/xinitrc";
      };
    };

    services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };
  };
}
