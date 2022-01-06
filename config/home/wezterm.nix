{ style, ... }:

let 
  inherit (style.wezterm) font font_size window_padding color_scheme;
in {
	xdg.configFile."wezterm" = {
		target = "wezterm/wezterm.lua";
        text = ''
          local wezterm = require "wezterm"

          -- Wezterm does not watch if files get deleted which is what home manager does when changing generations, so we make a file that we write to whenever we want to reload wezterm externally
          wezterm.add_to_config_reload_watch_list(os.getenv("XDG_DATA_HOME") .. "/wezterm/reload.txt")

          return {
            font = wezterm.font "${font}",
            font_size = ${font_size},
            enable_tab_bar = false,
            show_update_window = false,
            check_for_updates = false,
            color_scheme_dirs = { os.getenv("DOT_ROOT") .. "/scripts/storage/wezterm/colors" },
            color_scheme = "${color_scheme}",
            automatically_reload_config = true,
            window_close_confirmation = "NeverPrompt",
            bold_brightens_ansi_colors = false,
            freetype_interpreter_version = 35,
            window_padding = {
              top = "${window_padding.top}",
              right = "${window_padding.right}",
              bottom = "${window_padding.bottom}",
              left = "${window_padding.left}",
            },
          }
        '';
        recursive = false;
	};

    xdg.configFile."wezterm-colors" = {
      target = "wezterm/colors";
      source = ../files/wezterm/colors;
      recursive = true;
    };
}
