local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#3c3836",
	border_focused = "#fe8019",
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
		bg = "#1d2021",
		-- alpha.bar.fg
		fg = "#d5c4a1",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#fe8019",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#b8bb26",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#665c54",
		-- alpha.bar.label_fg
		label_fg = "#d3869b",
		-- alpha.bar.decoration_fg
		decoration_fg = "#83a598",
		-- alpha.bar.muted_fg
		muted_fg = "#fb4934",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#fb4934",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#fabd2f",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#b8bb26",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#3c3836",
		-- alpha.titlebar.fg_normal
		fg_normal = "#fe8019",
		-- alpha.titlebar.bg_focused
		bg_focused = "#fe8019",
		-- alpha.titlebar.fg_focused
		fg_focused = "#3c3836",
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
