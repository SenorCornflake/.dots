{ config, pkgs, lib, style, ... }:

(import ./first.nix { inherit config pkgs lib style; } ) // {
  border_width = "0";
  title_height = "0";
  title_font = "Terminus:size=10:style=bold";
  padding_top = "0";
  outer_width = "2";
  inner_width = "2";
  window_gap = "15";
}
