local xresources = require("beautiful.xresources")
local gears = require("gears")

local theme = {}

-- Generic Settings
theme.general = {
	border_normal = "#1b1b1b",
	border_focused = "#6a7fd2",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "/home/breton/Pictures/wallpapers/generated_from_picture.jpg",
}


-- Alpha Theme Settings
theme.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Dina 7",
		-- alpha.bar.bg
		bg = "#111111",
		-- alpha.bar.fg
		fg = "#ababab",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#6a7fd2",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#7f8b00",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#777777",
		-- alpha.bar.label_fg
		label_fg = "#6a7fd2",
		-- alpha.bar.decoration_fg
		decoration_fg = "#008dd1",
		-- alpha.bar.muted_fg
		muted_fg = "#f04339",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#f04339",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#bb8801",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#7f8b00",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#1b1b1b",
		-- alpha.titlebar.fg_normal
		fg_normal = "#6a7fd2",
		-- alpha.titlebar.bg_focused
		bg_focused = "#6a7fd2",
		-- alpha.titlebar.fg_focused
		fg_focused = "#1b1b1b",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#111111",
		-- alpha.notification.fg
		fg = "#ababab",
		-- alpha.notification.font
		font = "Dina 7",
		-- alpha.notification.spacing
		spacing = 10
	}
}

-- Bravo Theme Settings
theme.bravo = {
	bar = {
		-- bravo.bar.font
		font = "Dina 7",
		-- bravo.bar.bg
		bg = "#111111",
		-- bravo.bar.fg
		fg = "#ababab",
		-- bravo.bar.sep_fg
		sep_fg = "#262626",
		-- bravo.bar.label_fg
		label_fg = "#008dd1",
		-- bravo.bar.focused_tag_fg
		focused_tag_fg = "#6a7fd2",
		-- bravo.bar.occupied_tag_fg
		occupied_tag_fg = "#bb8801",
		-- bravo.bar.empty_tag_fg
		empty_tag_fg = "#777777",
		-- bravo.bar.muted_fg
		muted_fg = "#f04339",
	},
	notification = {
		-- bravo.notification.bg
		bg = "#111111",
		-- bravo.notification.fg
		fg = "#ababab",
		-- bravo.notification.font
		font = "Dina 7",
		-- bravo.notification.spacing
		spacing = 0
	}
}
theme.bar = "bravo"
theme.titlebar = "bravo"
theme.notification = "alpha"

theme.notification_spacing = theme[theme.notification].notification.spacing

return theme
