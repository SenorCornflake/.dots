local xresources = require("beautiful.xresources")
local gears = require("gears")

local theme = {}

-- Generic Settings
theme.general = {
	border_normal = "#444267",
	border_focused = "#676E95",
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
		bg = "#292D3E",
		-- alpha.bar.fg
		fg = "#959DCB",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#C792EA",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#C3E88D",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#676E95",
		-- alpha.bar.label_fg
		label_fg = "#89DDFF",
		-- alpha.bar.decoration_fg
		decoration_fg = "#82AAFF",
		-- alpha.bar.muted_fg
		muted_fg = "#F07178",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#F07178",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#FFCB6B",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#C3E88D",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#444267",
		-- alpha.titlebar.fg_normal
		fg_normal = "#959DCB",
		-- alpha.titlebar.bg_focused
		bg_focused = "#676E95",
		-- alpha.titlebar.fg_focused
		fg_focused = "#959DCB",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#292D3E",
		-- alpha.notification.fg
		fg = "#959DCB",
		-- alpha.notification.border_color
		border_color = "#FF5370",
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
		bg = "#292D3E",
		-- bravo.bar.fg
		fg = "#959DCB",
		-- bravo.bar.sep_fg
		sep_fg = "#32374D",
		-- bravo.bar.label_fg
		label_fg = "#82AAFF",
		-- bravo.bar.focused_tag_fg
		focused_tag_fg = "#C792EA",
		-- bravo.bar.occupied_tag_fg
		occupied_tag_fg = "#FFCB6B",
		-- bravo.bar.empty_tag_fg
		empty_tag_fg = "#676E95",
		-- bravo.bar.muted_fg
		muted_fg = "#F07178",
	}
}
theme.bar = "bravo"
theme.titlebar = "none"
theme.notification = "alpha"

theme.notification_spacing = theme[theme.notification].notification.spacing

return theme
