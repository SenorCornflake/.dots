local dpi = require "beautiful.xresources".apply_dpi

local theme = {}

theme.init = function()
	require "beautiful".init(require "gears".filesystem.get_configuration_dir() .. "/CONFIG/theme.lua")
end

-------------
-- GENERAL --
-------------
theme.general_borderNormal = "#3c3836"
theme.general_borderFocused = "#d5c4a1"
theme.general_borderWidth = dpi(2)
theme.general_gapSize = dpi(5)
theme.general_wallpaper = "/home/breton/Pictures/wallpapers/generated_from_picture.jpg"
theme.general_bar = "bravo"
theme.general_titlebar = "none"

-----------
-- ALPHA --
-----------
theme.alpha_bar_font = "Sarasa Mono CL 10"
theme.alpha_bar_bg = "#1d2021"
theme.alpha_bar_fg = "#d5c4a1"
theme.alpha_bar_focusedTagFg = "#d3869b"
theme.alpha_bar_occupiedTagFg = "#b8bb26"
theme.alpha_bar_emptyTagFg = "#665c54"
theme.alpha_bar_labelFg = "#8ec07c"
theme.alpha_bar_decorationFg = "#83a598"
theme.alpha_bar_mutedFg = "#fb4934"
theme.alpha_bar_lowBatteryFg = "#fb4934"
theme.alpha_bar_middleBatteryFg = "#fabd2f"
theme.alpha_bar_fullBatteryFg = "#b8bb26"

theme.alpha_titlebar_font = "Sarasa Mono CL 10"
theme.alpha_titlebar_bgNormal = "#3c3836"
theme.alpha_titlebar_fgNormal = "#d5c4a1"
theme.alpha_titlebar_bgFocused = "#d5c4a1"
theme.alpha_titlebar_fgFocused = "#d5c4a1"

-----------
-- BRAVO --
-----------
theme.bravo_bar_font = "Sarasa Mono CL 10"
theme.bravo_bar_bg = "#1d2021"
theme.bravo_bar_fg = "#d5c4a1"
theme.bravo_bar_sepFg = "#504945"
theme.bravo_bar_labelFg = "#83a598"
theme.bravo_bar_focusedTagFg = "#d3869b"
theme.bravo_bar_occupiedTagFg = "#fabd2f"
theme.bravo_bar_emptyTagFg = "#665c54"
theme.bravo_bar_mutedFg = "#fb4934"

return theme
