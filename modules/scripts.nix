{ config, pkgs, lib, ... }:

# TODO: Move these into seperate files
let
  inherit (config.modules.window-managers) herbstluftwm;
in
{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "writeiso" ''
      sudo dd bs=4M if=$1 of=$2 conv=fdatasync status=progress
    '')

    redshift
    (writeShellScriptBin "restore_nightmode_state" ''
      if [[ -f $XDG_DATA_HOME/dotfiles/nightmode ]]; then
        redshift -x
        redshift -O 4500
      else
        redshift -x
        redshift -O 6500
      fi
    '')

    (writeShellScriptBin "toggle_nightmode" ''
      if [[ -f $XDG_DATA_HOME/dotfiles/nightmode ]]; then
        rm $XDG_DATA_HOME/dotfiles/nightmode
        redshift -x
        redshift -O 6500
      else
        touch $XDG_DATA_HOME/dotfiles/nightmode
        redshift -x
        redshift -O 4500
      fi
    '')

    git
    (writeShellScriptBin "switch" ''
      pushd $HOME/.dots
      git add .
      nixos-rebuild switch --flake .# --impure --use-remote-sudo
      popd
    '')

    (writeShellScriptBin "clean" ''
      echo "Collecting Garbage..."
      sudo nix-collect-garbage --delete-old
      nix-collect-garbage --delete-old
      echo "Optimizing store..."
      sudo nix-store --optimize
      nix-store --optimize
      echo "Done!"
    '')

    (writeShellScriptBin "update" ''
      pushd $HOME/.dots
      nix flake update
      popd
    '')

    (makeDesktopItem {
      name = "xm-mt5";
      desktopName = "XM MetaTrader 5";
      exec = "wine \"/home/a/.wine/drive_c/Program Files/XM Global MT5/terminal64.exe\"";
      terminal = false;
    })

    # TODO: Create backup script that automatically places all files needed into a specified location
    (writeShellScriptBin "backup" ''
      date=$(date)

      echo "Backing dotfiles"
      pushd ${config.dotsDir}
      git add .
      git commit -m "BACKUP $date"
      git push
      popd
      echo "done."

      echo "Backing websites"
      pushd /srv/http
      git add .
      git commit -m "BACKUP $date"
      git push
      popd
      echo "done."

      echo "Backing databases"
      pushd ~
      if [[ ! -d ~/databases ]]; then
        git clone https://github.com/SenorCornflake/databases
      fi
      popd

      sudo find /var/lib/mysql -maxdepth 1 -mindepth 1 -type d | while read dir; do
        if [[ $(echo $dir | grep "_dv") ]]; then
          name=$(basename $dir)
          mysqldump -u root --password=root $name > ~/databases/$name.sql
        fi
      done

      sudo chmod -R 755 ~/databases

      pushd ~/databases
      git add .
      git commit -m "BACKUP $date"
      git push
      popd
      echo "done."
    '')

    (writeShellScriptBin "set_alternative_wallpaper" ''
      wallpaper=$(echo `ls ${config.wallpaperDir}` | rofi -sep " " -dmenu)

      if [[ $wallpaper != "" ]]; then
        echo -n "${config.wallpaperDir}/$wallpaper" > $XDG_DATA_HOME/dotfiles/alternative_wallpaper
        feh --no-fehbg --bg-fill ${config.wallpaperDir}/$wallpaper
      fi
    '')

    flavours
    (writeShellScriptBin "setup_base16" ''
      # Generate kitty theme
      flavours build $XDG_DATA_HOME/dotfiles/base16.yaml $XDG_DATA_HOME/flavours/base16/templates/kitty/templates/default.mustache > $XDG_DATA_HOME/dotfiles/kitty.conf

      switch
      reload_wm
      reload_neovim
    '')

    (writeShellScriptBin "reload_wm"
      (if herbstluftwm.enable
        then "herbstclient reload"
        else "echo \"Update this command to support the current window manager\""))

    neovim-command
    (writeShellScriptBin "reload_neovim" ''
      neovim-command "lua LOAD_THEME()"
    '')

    yq
    pywal
    schemer2
    colorz
    python3Packages.colorthief
    haishoku
    auto-base16-theme
    (writeShellScriptBin "generate_base16_theme" ''
      wallpaper=$(echo `ls ${config.wallpaperDir}` | rofi -sep " " -dmenu)

      if [[ $wallpaper == "" ]]; then
        exit
      fi

      if [[ $1 == "flavours" ]]; then
        if [[ $wallpaper != "" ]]; then
          notify-send "Flavours" "Generating $2 base16 theme using $wallpaper"
          flavours generate $2 ${config.wallpaperDir}/$wallpaper --stdout > $XDG_DATA_HOME/dotfiles/base16.yaml
          flavours generate $2 ${config.wallpaperDir}/$wallpaper --stdout | yq > $XDG_DATA_HOME/dotfiles/base16.json
        fi
      elif [[ $1 == "schemer2" ]]; then
        template="scheme: \"Generated\"
      author: \"Schemer2\"

      base00: \"{}\"
      base01: \"{}\"
      base02: \"{}\"
      base03: \"{}\"
      base04: \"{}\"
      base05: \"{}\"
      base06: \"{}\"
      base07: \"{}\"

      base08: \"{}\"
      base09: \"{}\"
      base0A: \"{}\"
      base0B: \"{}\"
      base0C: \"{}\"
      base0D: \"{}\"
      base0E: \"{}\"
      base0F: \"{}\"
        "

        echo "$template" > $XDG_DATA_HOME/dotfiles/auto-base16-template.el

        notify-send "Schemer2" "Generating base16 theme using $wallpaper"
        # Generate the colors with schemer2
        schemer2 -format img::colors -in "${config.wallpaperDir}/$wallpaper" -out "$XDG_DATA_HOME/dotfiles/colors.txt"
        # Create the base16 theme with this
        auto-base16-theme --inputColorPaletteFile $XDG_DATA_HOME/dotfiles/colors.txt $XDG_DATA_HOME/dotfiles/auto-base16-template.el $XDG_DATA_HOME/dotfiles/base16.yaml
        # Create JSON version of base16 theme
        echo "$(cat $XDG_DATA_HOME/dotfiles/base16.yaml)" | yq > $XDG_DATA_HOME/dotfiles/base16.json
      elif [[ $1 == "pywal" ]]; then
        if [[ $2 == "light" ]]; then
          wal -l -n -e -s -t --backend $3 -i ${config.wallpaperDir}/$wallpaper
        else
          wal -n -e -s -t --backend $3 -i ${config.wallpaperDir}/$wallpaper
        fi

        color0=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color0" | sed "s/#//g")
        color1=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color1" | sed "s/#//g")
        color2=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color2" | sed "s/#//g")
        color3=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color3" | sed "s/#//g")
        color4=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color4" | sed "s/#//g")
        color5=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color5" | sed "s/#//g")
        color6=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color6" | sed "s/#//g")
        color7=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color7" | sed "s/#//g")
        color8=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color8" | sed "s/#//g")
        color9=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color9" | sed "s/#//g")
        color10=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color10" | sed "s/#//g")
        color11=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color11" | sed "s/#//g")
        color12=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color12" | sed "s/#//g")
        color13=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color13" | sed "s/#//g")
        color14=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color14" | sed "s/#//g")
        color15=$(cat $XDG_CACHE_HOME/wal/colors.json | jq -r ".colors.color15" | sed "s/#//g")

        base16="
      scheme: \"Generated\"
      author: \"Pywal\"

      base00: \"$color0\"
      base01: \"$color10\"
      base02: \"$color11\"
      base03: \"$color8\"
      base04: \"$color12\"
      base05: \"$color7\"
      base06: \"$color13\"
      base07: \"$color15\"

      base08: \"$color1\"
      base09: \"$color9\"
      base0A: \"$color3\"
      base0B: \"$color2\"
      base0C: \"$color6\"
      base0D: \"$color4\"
      base0E: \"$color5\"
      base0F: \"$color14\"
        "

        echo "$base16" > $XDG_DATA_HOME/dotfiles/base16.yaml
        echo "$base16" | yq > $XDG_DATA_HOME/dotfiles/base16.json
      fi

      echo -n "${config.wallpaperDir}/$wallpaper" > $XDG_DATA_HOME/dotfiles/alternative_wallpaper
      setup_base16
    '')

    (writeScriptBin "keyboard_layout" ''
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
    '')
  ];
  # TODO: See if treesitter can enable syntax highlighting for bash in strings
}
