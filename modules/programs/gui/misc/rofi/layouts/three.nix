{ config, lib, pkgs, ... }:

let 
  inherit (lib) mkIf mkMerge types recursiveUpdate;
  inherit (lib.my) mkBoolOpt mkOpt;
  cfg = config.modules.programs.gui.misc.rofi;

  scheme = recursiveUpdate 
    {
      bg = "#111111";
      fg = "#aaaaaa";
      alt-bg = "#333333";
      accent = "#009999";
      border = "#aa4499";
    }
    cfg.scheme;

  l = config.home-manager.users."${config.userName}".lib.formats.rasi.mkLiteral;
  terminal = config.modules.programs.gui.terminals.default;
in

{
  config = mkMerge [
    (mkIf (cfg.layout == "three") {
      fonts.fonts = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "Iosevka"
          ];
        })
        material-design-icons
      ];

      home-manager.users."${config.userName}" = {
        home.packages = with pkgs; [
          paper-icon-theme
        ];

        programs.rofi = {
          location = "top";
          extraConfig = {
            font = "Iosevka Nerd Font 10";
            terminal = "${pkgs."${terminal}"}/bin/${terminal}";
            show-icons = true;
            icon-theme = "Paper";
            display-drun = "󱗼";
            display-dmenu = "l";
          };
          theme = {
            "*" = {
              text-color = l scheme.fg;
            };
            window = {
              transparency = "real";
              width = l "100%";
              height = l "calc(30%)";
              y-offset = l "0";
              x-offset = l "0";
              border = l "0";
              children = map l [ "listview" "inputbar" ];
              spacing = 0;
              padding = l "15px";
              background-color = l scheme.bg;
            };

            listview = {
              fixed-height = true;
              columns = 5;
              spacing = l "0px";
              margin = l "0px";
              background-color = l "#00000000";
            };

            inputbar = {
              padding = l "3px";
              margin = l "10px 0px 0px 0px";
              text-color = l scheme.fg;
              spacing = 0;
              children = map l [ "prompt" "entry" "num-filtered-rows" ];
              background-color = l "#00000000";
            };

            num-filtered-rows = {
              padding = l "5px";
              vertical-align = l "0.5";
              text-color = l "inherit";
              background-color = l "#00000000";
            };

            entry = {
              padding = l "5px";
              text-color = l scheme.fg;
              vertical-align = l "0.5";
              expand = true;
              background-color = l "#00000000";
              #placeholder = "Search...";
            };

            prompt = {
              text-color = l "inherit";
              padding = l "5px";
              vertical-align = l "0.5";
              background-color = l "#00000000";
            };

            element = {
              padding = l "5px";
              background-color = l "#00000000";
            };

            "element selected" = {
              text-color = l scheme.bg;
              background-color = l scheme.accent;
              border = l "0";
              border-color = l scheme.accent;
            };

            element-text = {
              vertical-align = l "0.5";
              background-color = l "#00000000";
            };

            "element-text selected" = {
              background-color = l scheme.accent;
              text-color = l scheme.bg;
            };

            element-icon = {
              padding = l "0px 5px";
              background-color = l "#00000000";
            };

            "element-icon selected" = {
              text-color = l "inherit";
              background-color = l scheme.accent;
            };
          };
        };
      };
    })
  ];
}
