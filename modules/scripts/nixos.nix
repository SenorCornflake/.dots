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
      git
    ];

    scripts = {
      switch = (writeShellScriptBin "switch" ''
        pushd $HOME/.dots
        git add .
        nixos-rebuild switch --flake .# --impure --use-remote-sudo
        popd
      '');

      clean = (writeShellScriptBin "clean" ''
        echo "Collecting Garbage..."
        sudo nix-collect-garbage --delete-old
        nix-collect-garbage --delete-old
        echo "Optimizing store..."
        sudo nix-store --optimize
        nix-store --optimize
        echo "Done!"
      '');

      update = (writeShellScriptBin "update" ''
        pushd $HOME/.dots
        nix flake update
        popd
      '');

      backup = (writeShellScriptBin "backup" ''
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
          if [[ $(echo $dir | grep "dv") ]]; then
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
      '');
    };
  };
}
