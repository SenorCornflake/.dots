local xresources = require("beautiful.xresources")
local gears = require("gears")

local M = {}

-- Generic Settings
M.general = {
	border_normal = "#1b1b1b",
	border_focused = "#df5923",
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
		bg = "#111111",
		-- alpha.bar.fg
		fg = "#ababab",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#df5923",
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
		fg_normal = "#df5923",
		-- alpha.titlebar.bg_focused
		bg_focused = "#df5923",
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

M.bar = "alpha"
M.titlebar = "alpha"
M.notification = "alpha"

if M.notification == "alpha" then
	M.notification_spacing = M.alpha.notification.spacing
end


return M
