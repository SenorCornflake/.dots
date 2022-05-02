{ config, pkgs, lib, ... }:

let
  inherit (config.modules.window-managers) herbstluftwm;
  inherit (lib.my) mkOpt;
  inherit (lib) attrValues types concatStringsSep attrNames;
  inherit (pkgs) writeScriptBin writeShellScriptBin makeDesktopItem;
  inherit (builtins) readDir replaceStrings;
in
{
  config = {
    environment.systemPackages = with pkgs; [
      redshift
    ];

    scripts = {
      restore_nightmode_state = (writeShellScriptBin "restore_nightmode_state" ''
        file=$XDG_DATA_HOME/dotfiles/nightmode

        if [[ ! -f $file ]]; then
          echo -n "disabled" > $file
        elif [[ $(cat $file) == "enabled" ]]; then
          redshift -x
          redshift -O 4500
        else
          redshift -x
          redshift -O 6500
        fi
      '');

      toggle_nightmode = (writeShellScriptBin "toggle_nightmode" ''
        PATH=${lib.makeBinPath (with pkgs; [coreutils redshift])}

        file=/home/a/.local/share/dotfiles/nightmode

        if [[ ! -f $file ]]; then
          echo -n "enabled" > $file
          redshift -x
          redshift -O 4500
        elif [[ $(cat $file) == "enabled" ]]; then
          redshift -x
          redshift -O 6500
          echo -n "disabled" > $file
        else
          redshift -x
          redshift -O 4500
          echo -n "enabled" > $file
        fi
      '');
    };
  };
}
