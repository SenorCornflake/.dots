{ config, pkgs, style, ... }:

{
  location = "center";
  extraConfig = {
    font = "Iosevka Nerd font 9";
    terminal = "${pkgs.kitty}/bin/kitty";
    show-icons = false;
    drun-display-format = "{name}";
    display-drun = ">> ";
  };
  theme = let
    inherit (config.lib.formats.rasi) mkLiteral;
    inherit (style.rofi.second) bg fg border active_bg;
  in {
    window = {
      width = mkLiteral "80%";
      height = mkLiteral "60%";
      location = "center";
      anchor = "center";
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
      border = mkLiteral "3px";
      border-color = mkLiteral border;
    };

    mainbox = {
      children = map mkLiteral [ "listview" "inputbar" ];
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
      orientation = mkLiteral "vertical";
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
      columns = 10;
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
      background-color = mkLiteral bg;
      text-color = mkLiteral fg;
    };

    "element-text.selected" = {
      background-color = mkLiteral active_bg;
      text-color = mkLiteral bg;
    };

    "element.selected" = {
      background-color = mkLiteral active_bg;
      text-color = mkLiteral bg;
    };
  };
}
