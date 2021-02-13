local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#bcb9bc",
	border_focused = "#745b53",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/horizon-mandalorian.jpg",
}


-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#dae1e4",
		-- alpha.bar.fg
		fg = "#421c1b",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#745b53",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#9e4637",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#7f6b6c",
		-- alpha.bar.label_fg
		label_fg = "#904e46",
		-- alpha.bar.decoration_fg
		decoration_fg = "#af1a17",
		-- alpha.bar.muted_fg
		muted_fg = "#596266",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#596266",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#5d575e",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#9e4637",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#bcb9bc",
		-- alpha.titlebar.fg_normal
		fg_normal = "#745b53",
		-- alpha.titlebar.bg_focused
		bg_focused = "#745b53",
		-- alpha.titlebar.fg_focused
		fg_focused = "#bcb9bc",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#dae1e4",
		-- alpha.notification.fg
		fg = "#421c1b",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
