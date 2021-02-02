local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#171717",
	border_focused = "#a08c50",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/creepy-dry-grass-dry-tree-shack.png",
}

-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#070700",
		-- alpha.bar.fg
		fg = "#a08c50",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#a08c50",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#909c90",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#585858",
		-- alpha.bar.label_fg
		label_fg = "#a08c50",
		-- alpha.bar.decoration_fg
		decoration_fg = "#a08c50",
		-- alpha.bar.muted_fg
		muted_fg = "#909c90",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#909c90",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#a08c50",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#909c90",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#171717",
		-- alpha.titlebar.fg_normal
		fg_normal = "#a08c50",
		-- alpha.titlebar.bg_focused
		bg_focused = "#a08c50",
		-- alpha.titlebar.fg_focused
		fg_focused = "#171717",
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
