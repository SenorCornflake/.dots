{ config, pkgs, lib, ... }:

let 
  inherit (lib) optional types;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config;

  userName = "a";
  homeDir = "/home/${userName}";
in
{
  options = {
    userName = mkOpt types.str userName;
    configDir = mkOpt types.path ../config;
    wallpaperDir = mkOpt types.path ../wallpapers;
    dotsDir = mkOpt types.path (homeDir + "/.dots");

    dataHome = mkOpt types.path (homeDir + "/.local/share");
    configHome = mkOpt types.path (homeDir + "/.config");

    modules.has_opengl = mkBoolOpt true;
    modules.homePackages = mkOpt (types.listOf types.attrs) [];
  };

  config = {
    users.users."${config.userName}" = {
      name = config.userName;
      initialPassword = "a";
      isNormalUser = true;
      createHome = true;
      home = homeDir;
      extraGroups = 
        [ "wheel" ] ++
        (optional 
          config.networking.networkmanager.enable
          "networkmanager"); #++
        #(optional 
        #  config.networking.networkmanager.enable
        #  "nginx");
    };

    home-manager.users."${config.userName}".home.packages = cfg.modules.homePackages;
  };
}
