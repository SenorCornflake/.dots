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
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        herbstluftwm
        jq
        pulseaudio-ctl
        brightnessctl
        libnotify
        xkbset
      ];

      xdg.configFile."xinit/xinitrc" = {
        text = ''
          if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
              eval $(dbus-launch --exit-with-session --sh-syntax)
          fi
          systemctl --user import-environment DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_AUTH_SOCK XAUTHORITY XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID DOT_ROOT 

          if command -v dbus-update-activation-environment >/dev/null 2>&1; then
              dbus-update-activation-environment DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_AUTH_SOCK XAUTHORITY XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID DOT_ROOT 
          fi
          touch "$XDG_DATA_HOME/herbstluftwm/first_start.txt"
          exec herbstluftwm --locked
        '';
        executable = true;
        target = "xinit/xinitrc";
      };

      xdg.configFile."herbstluftwm/autostart" = {
        target = "herbstluftwm/autostart";
        executable = true;
        text = ''
          herbstclient unrule -F
          ${renderRules cfg.rules}

          herbstclient attr tiling.reset 1
          herbstclient attr floating.reset 1
          ${renderSettings cfg.settings}
          ${renderAttributes cfg.attributes}

          herbstclient keyunbind --all
          ${renderKeybinds cfg.keybinds}

          herbstclient mouseunbind --all
          ${renderMousebinds cfg.mousebinds}

          ${cfg.extraConfig}
        '';
      };
    };
  };
}
