local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#ebdbb2",
	border_focused = "#af3a03",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/circular-hovering-city-thing.jpg",
}

-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#f9f5d7",
		-- alpha.bar.fg
		fg = "#504945",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#af3a03",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#79740e",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#bdae93",
		-- alpha.bar.label_fg
		label_fg = "#8f3f71",
		-- alpha.bar.decoration_fg
		decoration_fg = "#076678",
		-- alpha.bar.muted_fg
		muted_fg = "#9d0006",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#9d0006",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#b57614",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#79740e",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#ebdbb2",
		-- alpha.titlebar.fg_normal
		fg_normal = "#af3a03",
		-- alpha.titlebar.bg_focused
		bg_focused = "#af3a03",
		-- alpha.titlebar.fg_focused
		fg_focused = "#ebdbb2",
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
