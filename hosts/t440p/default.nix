{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  modules = {
    homePackages = with pkgs; [
      ark
      extract-xiso
      filezilla
      gparted
      qbittorrent
      whatsapp-for-linux
      wineWowPackages.stableFull
      libreoffice
      vlc
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
          default = "kitty";
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
          zathura.enable = true;
        };
        games = {
          dwarf-fortress.enable = true;
        };
        graphics = {
          inkscape.enable = true;
        };
      };
      shell = {
        editors = {
          neovim.enable = true;
        };
        system = {
          bottom.enable = true;
          btop.enable = true;
        };
        file-managers = {
          lf.enable = true;
        };
        misc = {
          exa.enable = true;
          git.enable = true;
        };
        fetchers = {
          macchina.enable = true;
        };
      };
    };
  };

  system.stateVersion = "21.11";
}
