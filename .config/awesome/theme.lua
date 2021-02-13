local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#1f1d1c",
	border_focused = "#bd8465",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/generated_from_picture.jpg",
}


-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#0e0a0a",
		-- alpha.bar.fg
		fg = "#727a7c",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#bd8465",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#c9a470",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#6c5a5e",
		-- alpha.bar.label_fg
		label_fg = "#c9a470",
		-- alpha.bar.decoration_fg
		decoration_fg = "#9f7d74",
		-- alpha.bar.muted_fg
		muted_fg = "#e19d5c",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#e19d5c",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#8c8a8b",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#c9a470",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#1f1d1c",
		-- alpha.titlebar.fg_normal
		fg_normal = "#bd8465",
		-- alpha.titlebar.bg_focused
		bg_focused = "#bd8465",
		-- alpha.titlebar.fg_focused
		fg_focused = "#1f1d1c",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#0e0a0a",
		-- alpha.notification.fg
		fg = "#727a7c",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
