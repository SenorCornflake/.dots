{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "writeiso" ''
      sudo dd bs=4M if=$1 of=$2 conv=fdatasync status=progress
    '')

    (writeShellScriptBin "nightmode" ''
      sudo dd bs=4M if=$1 of=$2 conv=fdatasync status=progress
    '')
  ];
}
