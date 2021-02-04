local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#252525",
	border_focused = "#999999",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/space-portal.png",
}


-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#101010",
		-- alpha.bar.fg
		fg = "#b9b9b9",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#999999",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#8e8e8e",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#525252",
		-- alpha.bar.label_fg
		label_fg = "#747474",
		-- alpha.bar.decoration_fg
		decoration_fg = "#686868",
		-- alpha.bar.muted_fg
		muted_fg = "#7c7c7c",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#7c7c7c",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#a0a0a0",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#8e8e8e",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#252525",
		-- alpha.titlebar.fg_normal
		fg_normal = "#999999",
		-- alpha.titlebar.bg_focused
		bg_focused = "#999999",
		-- alpha.titlebar.fg_focused
		fg_focused = "#252525",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#101010",
		-- alpha.notification.fg
		fg = "#b9b9b9",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
