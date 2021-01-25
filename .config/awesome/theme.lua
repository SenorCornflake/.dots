local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#242422",
	border_focused = "#e9c062",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/generated.png",
}

-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#000000",
		-- alpha.bar.fg
		fg = "#b5b3aa",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#e9c062",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#a8ff60",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#6c6c66",
		-- alpha.bar.label_fg
		label_fg = "#ff73fd",
		-- alpha.bar.decoration_fg
		decoration_fg = "#96cbfe",
		-- alpha.bar.muted_fg
		muted_fg = "#ff6c60",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#ff6c60",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#ffffb6",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#a8ff60",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#242422",
		-- alpha.titlebar.fg_normal
		fg_normal = "#e9c062",
		-- alpha.titlebar.bg_focused
		bg_focused = "#e9c062",
		-- alpha.titlebar.fg_focused
		fg_focused = "#242422",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.launcher = "alpha"

M.notification_bg = M.alpha.bar.bg
M.notification_fg = M.alpha.bar.fg
M.notification_border_width = M.general.border_width
M.notification_border_color = M.general.border_focused
M.notification_font = M.alpha.bar.font

return M
