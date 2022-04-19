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

    (writeShellScriptBin "switch" ''
      pushd $HOME/.dots
      git add .
      sudo nixos-rebuild switch --flake .# --impure
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
          sudo cp -rf $dir ~/databases
        fi
      done

      pushd ~/databases
      git add .
      git commit -m "BACKUP $date"
      git push
      popd
      echo "done."
    '')

    (writeShellScriptBin "set_alternative_wallpaper" ''
      wallpaper=$(echo `ls ${config.wallpaperDir}` | rofi -sep " " -dmenu)
      echo -n "${config.wallpaperDir}/$wallpaper" > $XDG_DATA_HOME/dotfiles/alternative_wallpaper
      feh --no-fehbg --bg-fill ${config.wallpaperDir}/$wallpaper
    '')

    flavours

    (writeShellScriptBin "setup_base16" ''
      # Generate kitty theme
      flavours build $XDG_DATA_HOME/dotfiles/base16.yaml $XDG_DATA_HOME/flavours/base16/templates/kitty/templates/default.mustache > $XDG_DATA_HOME/dotfiles/kitty.conf

      switch
      reload_wm
    '')

    (writeShellScriptBin "reload_wm"
      (if herbstluftwm.enable
        then "herbstclient reload"
        else "echo \"Update this command to support the current window manager\""))

    yq

    (writeShellScriptBin "generate_base16_theme" ''
      wallpaper=$(echo `ls ${config.wallpaperDir}` | rofi -sep " " -dmenu)

      flavours generate dark ${config.wallpaperDir}/$wallpaper --stdout > $XDG_DATA_HOME/dotfiles/base16.yaml
      flavours generate dark ${config.wallpaperDir}/$wallpaper --stdout | yq > $XDG_DATA_HOME/dotfiles/base16.json

      setup_base16
    '')
  ];
}
