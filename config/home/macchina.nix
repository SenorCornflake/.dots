{ config, pkgs, ... }:

{
  xdg.configFile."macchina.toml" = {
    recursive = true;
    target = "macchina";
    source = ../files/macchina;
  };
}
