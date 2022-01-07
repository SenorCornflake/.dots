{ config, pkgs, style, ... }:

{
  location = "bottom-left";
  extraConfig = {
    font = "Terminus 9";
    terminal = "${pkgs.kitty}/bin/kitty";
    show-icons = false;
    drun-display-format = "{name}";
    display-drun = ">> ";
  };
  theme = let
    inherit (config.lib.formats.rasi) mkLiteral;
    inherit (style.rofi.third) bg fg accent;
  in {
    window = {
      width = mkLiteral "20%";
      height = mkLiteral "calc(100% - 32px)";
      location = "south west";
      anchor = "south west";
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
    };

    mainbox = {
      children = map mkLiteral [ "listview" "inputbar" ];
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
      orientation = mkLiteral "vertical";
      border = mkLiteral "0px 0px 0px 2px";
      border-color = mkLiteral accent;
    };

    inputbar = {
      children = map mkLiteral [ "entry" ];
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
      padding = mkLiteral "5px";
    };

    entry = {
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
    };


    listview = {
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
      columns = 1;
      dynamic = true;
    };

    element = {
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
      padding = mkLiteral "8px";
    };

    element-text = {
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
    };

    element-icon = {
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
    };

    "element-icon.selected" = {
      background-color = mkLiteral accent;
      text-color = mkLiteral fg;
    };

    "element-text.selected" = {
      background-color = mkLiteral accent;
      text-color = mkLiteral bg;
    };

    "element.selected" = {
      background-color = mkLiteral accent;
      text-color = mkLiteral bg;
    };
  };
}
