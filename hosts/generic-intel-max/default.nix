{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  fonts.fonts = with pkgs; [
    scheherazade
    scheherazade-new
    amiri
  ];

  modules = {
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
      zeal

      extract-xiso
      xinput-gui
      remote-control-client

      nur.repos.makefu.bin2iso
      mdf2iso
    ];

    kernel = {
      useLatestKernel = true;
    };

    databases = {
      mysql.enable = true;
    };

    misc = {
      grub.enable = true;
    };

    networking = {
      interface = "wlp3s0";

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

  system.stateVersion = "22.05";
}
