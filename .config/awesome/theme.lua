local xresources = require("beautiful.xresources")
local gears = require("gears")

local theme = {}

-- Generic Settings
theme.general = {
	border_normal = "#3c3836",
	border_focused = "#665c54",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/generated.png",
}


-- Alpha Theme Settings
theme.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#1d2021",
		-- alpha.bar.fg
		fg = "#d5c4a1",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#d3869b",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#b8bb26",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#665c54",
		-- alpha.bar.label_fg
		label_fg = "#8ec07c",
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
		fg_normal = "#d5c4a1",
		-- alpha.titlebar.bg_focused
		bg_focused = "#665c54",
		-- alpha.titlebar.fg_focused
		fg_focused = "#d5c4a1",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#1d2021",
		-- alpha.notification.fg
		fg = "#d5c4a1",
		-- alpha.notification.border_color
		border_color = "#d65d0e",
		-- alpha.notification.font
		font = "Dina 7",
		-- alpha.notification.spacing
		spacing = 10,
	}
}

-- Bravo Theme Settings
theme.bravo = {
	bar = {
		-- bravo.bar.font
		font = "Dina 7",
		-- bravo.bar.bg
		bg = "#1d2021",
		-- bravo.bar.fg
		fg = "#d5c4a1",
		-- bravo.bar.sep_fg
		sep_fg = "#504945",
		-- bravo.bar.label_fg
		label_fg = "#83a598",
		-- bravo.bar.focused_tag_fg
		focused_tag_fg = "#d3869b",
		-- bravo.bar.occupied_tag_fg
		occupied_tag_fg = "#fabd2f",
		-- bravo.bar.empty_tag_fg
		empty_tag_fg = "#665c54",
		-- bravo.bar.muted_fg
		muted_fg = "#fb4934",
	}
}
theme.bar = "bravo"
theme.titlebar = "none"
theme.notification = "alpha"

theme.notification_spacing = theme[theme.notification].notification.spacing

return theme
