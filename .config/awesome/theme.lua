local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#2e221e",
	border_focused = "#4aa6bf",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/cube-middle-weird.jpeg",
}


-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#101816",
		-- alpha.bar.fg
		fg = "#3887c0",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#4aa6bf",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#e54755",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#606169",
		-- alpha.bar.label_fg
		label_fg = "#65a0a4",
		-- alpha.bar.decoration_fg
		decoration_fg = "#7d8997",
		-- alpha.bar.muted_fg
		muted_fg = "#d45077",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#d45077",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#6be4b9",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#e54755",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#2e221e",
		-- alpha.titlebar.fg_normal
		fg_normal = "#4aa6bf",
		-- alpha.titlebar.bg_focused
		bg_focused = "#4aa6bf",
		-- alpha.titlebar.fg_focused
		fg_focused = "#2e221e",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#101816",
		-- alpha.notification.fg
		fg = "#3887c0",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
