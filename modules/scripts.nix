{ config, pkgs, lib, ... }:

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
  ];
}
