{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  modules = {
    network_interface = "wlp3s0";

    homePackages = with pkgs; [
      ark
      filezilla
      gparted
      qbittorrent
      whatsapp-for-linux
      wineWowPackages.stagingFull
      winetricks
      libreoffice
      vlc
      blueberry
      lutris
      barrier
      mindustry
      blender
      krita
      gimp

      extract-xiso
      xinput-gui
      remote-control-client
    ];

    kernel = {
      useLatestKernel = true;
    };

    databases = {
      mysql.enable = true;
    };

    misc = {
      grub.enable = true;

      autorandr = {
        profiles = (import ./autorandr-profiles.nix);
      };
    };

    networking = {
      networkmanager.enable = true;
      ssh.enable = true;

      samba = {
        enable = true;
        openDirs = {
          root = "/";
        };
      };

      servers = {
        apache.enable = true;
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
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

    desktop-environments = {
      kde.enable = false;
      gnome.enable = false;
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
