{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types recursiveUpdate;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.rofi;

  scheme = recursiveUpdate 
    {
      bg = "#111111";
      fg = "#aaaaaa";
      alt-bg = "#222222";
      alter-bg = "#333333";
      accent = "#009999";
      border = "#000000";
    }
    cfg.scheme;

  l = config.home-manager.users."${config.userName}".lib.formats.rasi.mkLiteral;
  terminal = config.modules.programs.gui.terminals.default;
in

{
  config = mkMerge [
    (mkIf (cfg.layout == "one") {
      fonts.fonts = with pkgs; [
        terminus_font
      ];

      home-manager.users."${config.userName}" = {
        home.packages = with pkgs; [
          paper-icon-theme
        ];

        programs.rofi = {
          location = "center";
          extraConfig = {
            font = "Terminus 9";
            terminal = "${pkgs."${terminal}"}/bin/${terminal}";
            show-icons = true;
            icon-theme = "Paper";
          };
          theme = {
            "*" = {
              background-color = l scheme.bg;
              border-color = l scheme.border;
              text-color = l scheme.fg;
            };
            window = {
              width = l "40%";
              height = l "50%";
              border = l "1px";
              border-color = l scheme.border;
              children = map l [ "inputbar" "listview" ];
              spacing = 0;
            };

            listview = {
              fixed-height = true;
              columns = 1;
              spacing = l "0px";
              scrollbar = true;
            };

            inputbar = {
              padding = l "0";
              spacing = 0;
              children = map l [ "prompt" "entry" "num-filtered-rows" ];
            };

            num-filtered-rows = {
              padding = l "10px";
              vertical-align = l "0.5";
              background-color = l scheme.alt-bg;
            };

            entry = {
              padding = l "10px";
              background-color = l scheme.alt-bg;
              vertical-align = l "0.5";
              expand = true;
            };

            prompt = {
              text-color = l scheme.accent;
              padding = l "10px";
              background-color = l scheme.alter-bg;
              vertical-align = l "0.5";
              border-color = l scheme.border;
              border = l "0 1px 0 0";
            };

            scrollbar = {
              handle-width = l "1px";
              background-color = l scheme.bg;
              handle-color = l scheme.accent;
            };

            element = {
              padding = l "10px";
              border = l "1px 0px 0px 0px";
              border-color = l scheme.border;
            };

            "element selected" = {
              background-color = l scheme.border;
            };

            element-text = {
              vertical-align = l "0.5";
            };

            "element-text selected" = {
              background-color = l "inherit";
            };

            element-icon = {
              padding = l "0px 5px";
            };

            "element-icon selected" = {
              background-color = l "inherit";
            };
          };
        };
      };
    })
  ];
}
