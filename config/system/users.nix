{ config, pkgs, lib, ... }:

{
  users.users.a = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "nginx" ];
    initialPassword = "a";
    shell = pkgs.zsh;
  };

  users.users.root = {
    initialHashedPassword = "a";
  };
}
