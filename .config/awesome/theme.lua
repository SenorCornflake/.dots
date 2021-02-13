local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#27292c",
	border_focused = "#ff9800",
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
		bg = "#202124",
		-- alpha.bar.fg
		fg = "#80868b",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#ff9800",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#00e676",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#44464d",
		-- alpha.bar.label_fg
		label_fg = "#673ab7",
		-- alpha.bar.decoration_fg
		decoration_fg = "#2196f3",
		-- alpha.bar.muted_fg
		muted_fg = "#f44336",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#f44336",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#ffeb3b",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#00e676",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#27292c",
		-- alpha.titlebar.fg_normal
		fg_normal = "#ff9800",
		-- alpha.titlebar.bg_focused
		bg_focused = "#ff9800",
		-- alpha.titlebar.fg_focused
		fg_focused = "#27292c",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#202124",
		-- alpha.notification.fg
		fg = "#80868b",
		-- alpha.notification.font
		font = "Dina 7",
	}
}

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

return M
