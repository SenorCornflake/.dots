local dpi = require "beautiful.xresources".apply_dpi

local theme = {}

theme.init = function()
	require "beautiful".init(require "gears".filesystem.get_configuration_dir() .. "/CONFIG/theme.lua")
end

-------------
-- GENERAL --
-------------
theme.general_borderNormal = "#2a2c3f"
theme.general_borderFocused = "#545c8c"
theme.general_borderWidth = 2
theme.general_borderWidth = dpi(theme.general_borderWidth)
theme.general_gapSize = 5
theme.general_gapSize = dpi(theme.general_gapSize)
theme.general_wallpaper = "~/Pictures/wallpapers/astronaut-powers-dogrun.jpg"
theme.general_bar = "bravo"
theme.general_titlebar = "none"

-----------
-- ALPHA --
-----------
theme.alpha_bar_font = "Sarasa Mono CL 10"
theme.alpha_bar_bg = "#222433"
theme.alpha_bar_fg = "#9ea3c0"
theme.alpha_bar_focusedTagFg = "#929be5"
theme.alpha_bar_occupiedTagFg = "#7cbe8c"
theme.alpha_bar_emptyTagFg = "#545c8c"
theme.alpha_bar_labelFg = "#b871b8"
theme.alpha_bar_decorationFg = "#929be5"
theme.alpha_bar_mutedFg = "#73c1a9"
theme.alpha_bar_lowBatteryFg = "#73c1a9"
theme.alpha_bar_middleBatteryFg = "#a8a384"
theme.alpha_bar_fullBatteryFg = "#7cbe8c"

theme.alpha_titlebar_font = "Sarasa Mono CL 10"
theme.alpha_titlebar_bgNormal = "#2a2c3f"
theme.alpha_titlebar_fgNormal = "#9ea3c0"
theme.alpha_titlebar_bgFocused = "#545c8c"
theme.alpha_titlebar_fgFocused = "#9ea3c0"

-----------
-- BRAVO --
-----------
theme.bravo_bar_font = "Sarasa Mono CL 10"
theme.bravo_bar_bg = "#222433"
theme.bravo_bar_fg = "#9ea3c0"
theme.bravo_bar_sepFg = "#363e7f"
theme.bravo_bar_labelFg = "#929be5"
theme.bravo_bar_focusedTagFg = "#929be5"
theme.bravo_bar_occupiedTagFg = "#a8a384"
theme.bravo_bar_emptyTagFg = "#545c8c"
theme.bravo_bar_mutedFg = "#73c1a9"

return theme
