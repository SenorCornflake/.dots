{ config, pkgs, lib, style, ... }:

(import ./first.nix { inherit config pkgs lib style; } ) // {
  border_width = "2";
  title_height = "20";
  title_font = "Iosevka Nerd Font:size=10:style=bold";
  padding_top = "10";
  outer_width = "3";
  inner_width = "3";
}
