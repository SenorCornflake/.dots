{ config, pkgs, style, ... }: 

let
  bar = import (./. + "/layouts/${style.polybar.layout}.nix") { inherit pkgs style; };
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
