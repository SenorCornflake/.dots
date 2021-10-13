{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    location = "bottom";
    extraConfig = {
      font = "Terminus 9";
      terminal = "${pkgs.kitty}/bin/kitty";
      show-icons = false;
      drun-display-format = "{name}";
      display-drun = ">> ";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
      bg = "#000000";
      fg = "#dddddd";
      border = "#8888ff";
      active_text = "#ddaa00";
      prompt = "#44dd44";
    in {
      window = {
        width = mkLiteral "100%";
        height = mkLiteral "10%";
        location = "southwest";
        anchor = "southwest";
        background-color = mkLiteral bg;
        text-color = mkLiteral fg;
        padding = mkLiteral "10";
        border = mkLiteral "2px 0 0 0";
        border-color = mkLiteral border;
      };

      mainbox = {
        children = map mkLiteral [ "listview" "inputbar" ];
        background-color = mkLiteral bg;
        text-color = mkLiteral fg;
        orientation = mkLiteral "vertical";
      };

      inputbar = {
        children = map mkLiteral [ "prompt" "entry" ];
        background-color = mkLiteral bg;
        text-color = mkLiteral fg;
        margin = mkLiteral "5px 0 0 0";
      };

      prompt = {
        background-color = mkLiteral bg;
        text-color = mkLiteral prompt;
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
        padding = mkLiteral "0 0 2px 0";
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
        text-color = mkLiteral active_text;
      };

      "element-text.selected" = {
        background-color = mkLiteral bg;
        text-color = mkLiteral active_text;
      };

      "element.selected" = {
        background-color = mkLiteral bg;
        text-color = mkLiteral active_text;
      };
    };
  };
}
