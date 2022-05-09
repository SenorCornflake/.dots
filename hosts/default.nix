{ inputs, lib, pkgs, config, ... }:

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

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    any-nix-shell
    git
    psmisc
    ntfs3g
    dosfstools
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    vulkan-tools
    xorg.xkill
  ];

  services.xserver = {
    xkbOptions = "keypad:pointerkeys,caps:backspace";
    autoRepeatDelay = 250;
    autoRepeatInterval = 30;
  };

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;

  home-manager.users."${config.userName}" = {
    home.keyboard = null;

    nixpkgs.config.allowUnfree = true;

    xdg.configFile."nixpkgs/config.nix" = {
      source = ../config/nixpkgs/config.nix;
    };

    xdg = {
      enable = true;
      configHome = config.configHome;
      dataHome = config.dataHome;
      cacheHome = config.users.users."${config.userName}".home + "/.cache/";
    };
  };
}
