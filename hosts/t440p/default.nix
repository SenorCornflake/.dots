{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  modules = {
    homePackages = with pkgs; [
      filezilla
      qbittorrent
      gparted
      wineWowPackages.stableFull
    ];

    theme = {
      layout = "one";
      scheme = "moonfly";
    };

    kernel = {
      useLatestKernel = true;
    };

    databases = {
      mysql.enable = true;
    };

    misc = {
      grub.enable = true;

      autorandr = {
        enable = true;
        profiles = (import ./autorandr-profiles.nix);
      };
    };

    networking = {
      networkmanager.enable = true;

      servers = {
        apache.enable = true;
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
        withGui = true;
      };
      audio = {
        pulseaudio = {
          enable = true;
        };
      };
    };

    window-managers = {
      herbstluftwm.enable = true;
      picom.enable = true;
    };

    shell = "zsh";

    programs = {
      gui = {
        browsers = {
          firefox.enable = true;
        };
        terminals = {
          kitty.enable = true;
        };
        media = {
          mpv.enable = true;
        };
        file-managers = {
          thunar.enable = true;
        };
        misc = {
          rofi.enable = true;
          polybar.enable = true;
          dunst.enable = true;
        };
      };
      shell = {
        editors = {
          neovim.enable = true;
        };
        system = {
          bottom.enable = true;
        };
        file-managers = {
          lf.enable = true;
        };
        misc = {
          exa.enable = true;
          macchina.enable = true;
          git.enable = true;
        };
      };
    };

  };

  system.stateVersion = "21.11";
}
