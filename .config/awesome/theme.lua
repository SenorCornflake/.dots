local xresources = require("beautiful.xresources")
local gears = require("gears")

local theme = {}

-- Generic Settings
theme.general = {
	border_normal = "#26232a",
	border_focused = "#655f6d",
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
		bg = "#19171c",
		-- alpha.bar.fg
		fg = "#8b8792",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#955ae7",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#2a9292",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#655f6d",
		-- alpha.bar.label_fg
		label_fg = "#398bc6",
		-- alpha.bar.decoration_fg
		decoration_fg = "#576ddb",
		-- alpha.bar.muted_fg
		muted_fg = "#be4678",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#be4678",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#a06e3b",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#2a9292",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Dina 7",
		-- alpha.titlebar.bg_normal
		bg_normal = "#26232a",
		-- alpha.titlebar.fg_normal
		fg_normal = "#8b8792",
		-- alpha.titlebar.bg_focused
		bg_focused = "#655f6d",
		-- alpha.titlebar.fg_focused
		fg_focused = "#8b8792",
	},
	notification = {
		-- alpha.notification.bg
		bg = "#19171c",
		-- alpha.notification.fg
		fg = "#8b8792",
		-- alpha.notification.border_color
		border_color = "#bf40bf",
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
		bg = "#19171c",
		-- bravo.bar.fg
		fg = "#8b8792",
		-- bravo.bar.sep_fg
		sep_fg = "#585260",
		-- bravo.bar.label_fg
		label_fg = "#576ddb",
		-- bravo.bar.focused_tag_fg
		focused_tag_fg = "#955ae7",
		-- bravo.bar.occupied_tag_fg
		occupied_tag_fg = "#a06e3b",
		-- bravo.bar.empty_tag_fg
		empty_tag_fg = "#655f6d",
		-- bravo.bar.muted_fg
		muted_fg = "#be4678",
	}
}
theme.bar = "bravo"
theme.titlebar = "none"
theme.notification = "alpha"

theme.notification_spacing = theme[theme.notification].notification.spacing

return theme
