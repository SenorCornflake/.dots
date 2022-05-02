{ config, pkgs, lib, ... }:

let
  inherit (config.modules.window-managers) herbstluftwm;
  inherit (lib.my) mkOpt;
  inherit (lib) attrValues types concatStringsSep attrNames;
  inherit (pkgs) writeScriptBin writeShellScriptBin makeDesktopItem;
  inherit (builtins) readDir replaceStrings;
in
{
  options = {
    scripts = mkOpt types.attrs {};
  };
  config = {
    environment.systemPackages = with pkgs; [
      neovim-command
    ] ++ (attrValues config.scripts);

    scripts = {
      writeiso = (writeShellScriptBin "writeiso" ''
        sudo dd bs=4M if=$1 of=$2 conv=fdatasync status=progress
      '');

      xm-mt5 = (makeDesktopItem {
        name = "xm-mt5";
        desktopName = "XM MetaTrader 5";
        exec = "wine \"/home/a/.wine/drive_c/Program Files/XM Global MT5/terminal64.exe\"";
        terminal = false;
      });

      reload_wm = (writeShellScriptBin "reload_wm"
        (if herbstluftwm.enable
          then "herbstclient reload"
          else "echo \"Update this command to support the current window manager\""));

      reload_neovim = (writeShellScriptBin "reload_neovim" ''
        neovim-command "lua LOAD_THEME()"
      '');

      keyboard_layout = (writeScriptBin "keyboard_layout" ''
        #!/usr/bin/env python

        import os

        layouts = [
            "us",
            "ara",
            "dvorak",
            "dvp",
        ]

        layouts = [
            { 
                "name": "US QWERTY",
                "layout": "us",
                "variant": "\"\""
            },
            { 
                "name": "US DVORAK Programmer",
                "layout": "us",
                "variant": "dvp"

            },
            { 
                "name": "US DVORAK",
                "layout": "us",
                "variant": "dvorak"
            },
            { 
                "name": "ARA QWERTY",
                "layout": "ara",
                "variant": "qwerty"
            }
        ]

        cmd = 'echo "{}" | rofi -dmenu -format i -i -p "Layout:"'.format("\n".join([layout["name"] for layout in layouts]))

        index = os.popen(cmd).read()[:-1]

        if index != "":
            index = int(index)
            layout = layouts[index]

            os.system("setxkbmap -layout {} -variant {}".format(layout["layout"], layout["variant"]))
      '');

      comma = (writeScriptBin "," ''
        nix shell nixpkgs#$1 -c "$(echo $1 | awk -F"." '{print $NF}')" "''${@:2}"
      '');
    };
  };
}
