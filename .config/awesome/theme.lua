local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#282a2e",
	border_focused = "#de935f",
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
		bg = "#1d1f21",
		-- alpha.bar.fg
		fg = "#c5c8c6",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#de935f",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#b5bd68",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#969896",
		-- alpha.bar.label_fg
		label_fg = "#b294bb",
		-- alpha.bar.decoration_fg
		decoration_fg = "#81a2be",
		-- alpha.bar.muted_fg
		muted_fg = "#cc6666",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#cc6666",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#f0c674",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#b5bd68",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#282a2e",
		-- alpha.titlebar.fg_normal
		fg_normal = "#de935f",
		-- alpha.titlebar.bg_focused
		bg_focused = "#de935f",
		-- alpha.titlebar.fg_focused
		fg_focused = "#282a2e",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#1d1f21",
		-- alpha.notification.fg
		fg = "#c5c8c6",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
