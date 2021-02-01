local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#1d2b53",
	border_focused = "#ffa300",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/generated.png",
}

-- Alpha Theme Settings
M.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#000000",
		-- alpha.bar.fg
		fg = "#5f574f",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#ffa300",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#00e756",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#008751",
		-- alpha.bar.label_fg
		label_fg = "#ff77a8",
		-- alpha.bar.decoration_fg
		decoration_fg = "#83769c",
		-- alpha.bar.muted_fg
		muted_fg = "#ff004d",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#ff004d",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#fff024",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#00e756",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#1d2b53",
		-- alpha.titlebar.fg_normal
		fg_normal = "#ffa300",
		-- alpha.titlebar.bg_focused
		bg_focused = "#ffa300",
		-- alpha.titlebar.fg_focused
		fg_focused = "#1d2b53",
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
