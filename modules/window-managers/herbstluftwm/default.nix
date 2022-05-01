{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf types escapeShellArg mapAttrsToList concatStringsSep isBool;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.window-managers.herbstluftwm;

  renderValue = val:
    if isBool val then
      if val then "true" else "false"
    else
      escapeShellArg val;

  renderAttributes = attributes:
    concatStringsSep "\n" (mapAttrsToList
      (name: value: "herbstclient attr ${name} ${renderValue value}") attributes);

  renderSettings = settings:
    concatStringsSep "\n" (mapAttrsToList
      (name: value: "herbstclient set ${name} ${renderValue value}") settings);

  renderKeybinds = keybinds:
    concatStringsSep "\n"
    (mapAttrsToList (key: cmd: "herbstclient keybind ${key} ${cmd}")
      keybinds);

  renderMousebinds = mousebinds:
    concatStringsSep "\n"
    (mapAttrsToList (btn: cmd: "herbstclient mousebind ${btn} ${cmd}")
      mousebinds);

  renderRules = rules:
    concatStringsSep "\n" (map (rule: "herbstclient rule ${rule}") rules);
in

{
  options.modules.window-managers.herbstluftwm = {
    enable = mkBoolOpt false;
    layout = mkOpt types.str "one";

    settings = mkOpt types.attrs {};
    attributes = mkOpt types.attrs {};
    keybinds = mkOpt types.attrs {};
    mousebinds = mkOpt types.attrs {};
    rules = mkOpt (types.listOf types.str) [];
    extraConfig = mkOpt types.str "";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
    };

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
              reload_wm
            '';
          };
        };
      };

      xdg.configFile."xinit/xinitrc" = {
        text = ''
          if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
              eval $(dbus-launch --exit-with-session --sh-syntax)
          fi
          systemctl --user import-environment XAUTHORITY DISPLAY DOT_ROOT

          if command -v dbus-update-activation-environment >/dev/null 2>&1; then
              dbus-update-activation-environment XAUTHORITY DISPLAY DOT_ROOT
          fi

          touch $HOME/first_start.txt
          exec herbstluftwm --locked
        '';
        executable = true;
        target = "xinit/xinitrc";
      };

      xdg.configFile."herbstluftwm/autostart" = {
        target = "herbstluftwm/autostart";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          herbstclient unrule -F
          herbstclient attr theme.tiling.reset 1
          herbstclient attr theme.floating.reset 1
          herbstclient keyunbind --all
          herbstclient mouseunbind --all

          ${cfg.extraConfig}

          ${renderRules cfg.rules}
          ${renderSettings cfg.settings}
          ${renderAttributes cfg.attributes}
          ${renderKeybinds cfg.keybinds}
          ${renderMousebinds cfg.mousebinds}

          herbstclient unlock
        '';
      };
    };
  };
}
