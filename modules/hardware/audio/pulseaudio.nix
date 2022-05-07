{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf;
  inherit (lib.my) mkBoolOpt;
  cfg = config.modules.hardware.audio.pulseaudio;
in

{
  options.modules.hardware.audio.pulseaudio = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;
  };
}

