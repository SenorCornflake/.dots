{ config, pkgs, lib, ... }:

let
  inherit (config.modules.window-managers) herbstluftwm;
  inherit (lib.my) mkOpt;
  inherit (lib) attrValues types concatStringsSep attrNames filterAttrs;
  inherit (pkgs) writeScriptBin writeShellScriptBin makeDesktopItem;
  inherit (builtins) readDir replaceStrings pathExists;
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
        #!${pkgs.python}/bin/python

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

        cmd = 'echo "{}" | ${pkgs.rofi}/bin/rofi -dmenu -format i -i -p "Layout:"'.format("\n".join([layout["name"] for layout in layouts]))

        index = os.popen(cmd).read()[:-1]

        if index != "":
            index = int(index)
            layout = layouts[index]

            os.system("${pkgs.xorg.setxkbmap}/bin/setxkbmap -layout {} -variant {}".format(layout["layout"], layout["variant"]))
      '');

      comma = (writeScriptBin "," ''
        nix shell nixpkgs#$1 -c "$(echo $1 | awk -F"." '{print $NF}')" "''${@:2}"
      '');

      server_status =
      let
        samba_shares =
          concatStringsSep
          " "
          (map
            (n: "\"${n}\"")
            (attrNames config.modules.networking.samba.openDirs));

        samba_dirs =
          concatStringsSep
          " "
          (map
            (n: "\"${n}\"")
            (attrValues config.modules.networking.samba.openDirs));

        apache_vhosts =
          if pathExists /srv/http then
            concatStringsSep
            " "
            (map
              (n: "\"${n}\"")
              (attrNames (filterAttrs (n: v: n != ".git" && n != "phpmyadmin") (readDir /srv/http))))
          else
            "";

      in (writeScriptBin "server_status" ''
        DELAY=5
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        PURPLE='\033[0;35m'
        BLUE='\033[0;34m'
        NC='\033[0m' # No Color

        SAMBA_SHARE_NAMES=(${samba_shares})
        SAMBA_SHARE_DIRS=(${samba_dirs})
        APACHE_VHOST_NAMES=(${apache_vhosts})

        while true; do
            clear

            text="''${BLUE}$(hostname)''${NC}\n\n"

            samba=$(sudo systemctl is-active samba.target)
            apache=$(sudo systemctl is-active httpd)


            if [[ $samba == "active" ]]; then
                text="$text''${GREEN}Samba active''${NC}"
                text="$text\n  ''${PURPLE}Shares:''${NC}"

                for((i=0;i<''${#SAMBA_SHARE_NAMES[@]};i++)); do
                    text="$text\n    ''${SAMBA_SHARE_NAMES[$i]}: ''${SAMBA_SHARE_DIRS[$i]}"
                done
            else
                text="''${RED}Samba inactive''${NC}"
            fi
            text="$text\n"

            if [[ $apache == "active" ]]; then
                text="$text\n''${GREEN}Apache active''${NC}"
                text="$text\n  ''${PURPLE}Virtual Hosts:''${NC}"

                for((i=0;i<''${#APACHE_VHOST_NAMES[@]};i++)); do
                    text="$text\n    ''${APACHE_VHOST_NAMES[$i]}"
                done

            else
                text="$text\n''${RED}Apache inactive''${NC}"
            fi

            echo -e "$text"
            sleep $DELAY
        done
      '');
    };
  };
}
