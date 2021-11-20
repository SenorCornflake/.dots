{ config, pkgs, ... }: 

let
  bar = ((import ./bars/simple.nix) pkgs);
in {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      alsaSupport = true;
      pulseSupport = true;
    };
    script = bar.script;
    settings = bar.settings;
  };
}
