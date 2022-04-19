{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.programs.gui.games.dwarf-fortress;
in
{
  options.modules.programs.gui.games.dwarf-fortress = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users."${config.userName}" = {
      home.packages = with pkgs; [
        (dwarf-fortress-packages.dwarf-fortress-full.override {
          enableIntro = false;
          enableTruetype = true;
          enableFPS = true;
          enableSound = false;
          enableSoundSense = true;
          enableStoneSense = false;
          enableDwarfTherapist = false;
          theme = dwarf-fortress-packages.themes.phoebus;
        })
      ];
    };
  };
}
