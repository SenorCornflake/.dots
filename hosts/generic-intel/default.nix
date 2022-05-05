{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  modules = {
    homePackages = with pkgs; [
      ark
      gparted
      blueberry
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
      networkmanager.enable = true;
      ssh.enable = true;
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
