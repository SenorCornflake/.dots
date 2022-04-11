{ config, pkgs, lib, ... }:

let 
  inherit (lib) optional types;
  inherit (lib.my) mkOpt;
  cfg = config;
in
{
  options = {
    userName = mkOpt types.str "a";
    configDir = mkOpt types.path ../config;
    wallpaperDir = mkOpt types.path ../wallpapers;

    modules.homePackages = mkOpt (types.listOf types.attrs) [];
  };

  config = {
    users.users."${config.userName}" = {
      name = config.userName;
      initialPassword = "a";
      isNormalUser = true;
      createHome = true;
      home = "/home/${config.userName}";
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
