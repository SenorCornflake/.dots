local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#323537",
	border_focused = "#cda869",
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
		bg = "#1e1e1e",
		-- alpha.bar.fg
		fg = "#a7a7a7",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#cda869",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#8f9d6a",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#5f5a60",
		-- alpha.bar.label_fg
		label_fg = "#9b859d",
		-- alpha.bar.decoration_fg
		decoration_fg = "#7587a6",
		-- alpha.bar.muted_fg
		muted_fg = "#cf6a4c",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#cf6a4c",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#f9ee98",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#8f9d6a",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#323537",
		-- alpha.titlebar.fg_normal
		fg_normal = "#cda869",
		-- alpha.titlebar.bg_focused
		bg_focused = "#cda869",
		-- alpha.titlebar.fg_focused
		fg_focused = "#323537",
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
