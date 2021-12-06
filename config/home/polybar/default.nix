{ config, pkgs, theme, ... }: 

let
  bar = import ./bars/simple.nix { inherit pkgs theme; };
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
