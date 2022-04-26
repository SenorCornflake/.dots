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
    (mkIf (cfg.layout == "two") {
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
          location = "top-left";
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
              background-color = l scheme.bg;
              border-color = l scheme.border;
              text-color = l scheme.fg;
            };
            window = {
              width = l "20%";
              height = l "calc(100% - 15px - 15px - 15px - 40px - 6px )";
              y-offset = l "calc(15px + 40px + 15px + 6px)";
              x-offset = l "calc(15px)";
              border = l "2px";
              border-color = l scheme.border;
              children = map l [ "inputbar" "listview" ];
              spacing = 0;
              padding = l "15px";
            };

            listview = {
              fixed-height = true;
              columns = 1;
              spacing = l "0px";
              margin = l "0px";
            };

            inputbar = {
              padding = l "3px";
              margin = l "0px 0px 10px 0px";
              background-color = l scheme.alt-bg;
              text-color = l scheme.fg;
              spacing = 0;
              children = map l [ "prompt" "entry" "num-filtered-rows" ];
            };

            num-filtered-rows = {
              padding = l "10px";
              vertical-align = l "0.5";
              background-color = l scheme.alt-bg;
              text-color = l "inherit";
            };

            entry = {
              padding = l "7px 10px";
              background-color = l scheme.alt-bg;
              text-color = l scheme.fg;
              vertical-align = l "0.5";
              expand = true;
              #placeholder = "Search...";
            };

            prompt = {
              text-color = l "inherit";
              padding = l "7px 10px";
              background-color = l "inherit";
              vertical-align = l "0.5";
            };

            element = {
              padding = l "10px";
            };

            "element selected" = {
              background-color = l scheme.accent;
              text-color = l scheme.bg;
            };

            element-text = {
              vertical-align = l "0.5";
            };

            "element-text selected" = {
              background-color = l "inherit";
              text-color = l "inherit";
            };

            element-icon = {
              padding = l "0px 5px";
            };

            "element-icon selected" = {
              background-color = l "inherit";
              text-color = l "inherit";
            };
          };
        };
      };
    })
  ];
}
