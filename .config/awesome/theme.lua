local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#101010",
	border_focused = "#9e9e9e",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/no-place-like-home.jpg",
}


-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#000000",
		-- alpha.bar.fg
		fg = "#747474",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#9e9e9e",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#747474",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#515151",
		-- alpha.bar.label_fg
		label_fg = "#9e9e9e",
		-- alpha.bar.decoration_fg
		decoration_fg = "#747474",
		-- alpha.bar.muted_fg
		muted_fg = "#8d8d8d",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#8d8d8d",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#747474",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#747474",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#101010",
		-- alpha.titlebar.fg_normal
		fg_normal = "#9e9e9e",
		-- alpha.titlebar.bg_focused
		bg_focused = "#9e9e9e",
		-- alpha.titlebar.fg_focused
		fg_focused = "#101010",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#000000",
		-- alpha.notification.fg
		fg = "#747474",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
