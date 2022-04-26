{ inputs, lib, pkgs, config, ... }:

let 
  inherit (lib.my) mapModulesRec;
  inherit (lib) mkDefault;
  inherit (builtins) pathExists readFile;
in
{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = (lib.optionalString (config.nix.package == pkgs.nixUnstable) "experimental-features = nix-command flakes");
    registry = {
      nixpkgs.flake = inputs.nixpkgs; # Pin the nixpkgs repo version used across the entire system with the flake cli
    };

    settings = {
      auto-optimise-store = true;
      substituters = [ 
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    any-nix-shell
    git
    psmisc
    ntfs3g
  ];

  home-manager.users."${config.userName}" = {
    xdg = {
      enable = true;
      configHome = config.users.users."${config.userName}".home + "/.config/";
      dataHome = config.users.users."${config.userName}".home + "/.local/share/";
      cacheHome = config.users.users."${config.userName}".home + "/.cache/";
    };
  };
}
