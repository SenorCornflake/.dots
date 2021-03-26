local xresources = require("beautiful.xresources")
local gears = require("gears")

local theme = {}

-- Generic Settings
theme.general = {
	border_normal = "#2a2c3f",
	border_focused = "#545c8c",
	border_width = xresources.apply_dpi(2),
	gap_size = xresources.apply_dpi(5),
	wallpaper = "~/Pictures/wallpapers/astronaut-powers-dogrun.jpg",
}


-- Alpha Theme Settings
theme.alpha = {
	bar = {
		-- alpha.bar.font
		font = "Sarasa Mono CL 10",
		-- alpha.bar.bg
		bg = "#222433",
		-- alpha.bar.fg
		fg = "#9ea3c0",
		-- alpha.bar.focused_tag_fg
		focused_tag_fg = "#929be5",
		-- alpha.bar.occupied_tag_fg
		occupied_tag_fg = "#7cbe8c",
		-- alpha.bar.empty_tag_fg
		empty_tag_fg = "#545c8c",
		-- alpha.bar.label_fg
		label_fg = "#b871b8",
		-- alpha.bar.decoration_fg
		decoration_fg = "#929be5",
		-- alpha.bar.muted_fg
		muted_fg = "#73c1a9",
		-- alpha.bar.low_battery_fg
		low_battery_fg = "#73c1a9",
		-- alpha.bar.middle_battery_fg
		middle_battery_fg = "#a8a384",
		-- alpha.bar.full_battery_fg
		full_battery_fg = "#7cbe8c",
	},
	titlebar = {
		-- alpha.titlebar.font
		font = "Sarasa Mono CL 10",
		-- alpha.titlebar.bg_normal
		bg_normal = "#2a2c3f",
		-- alpha.titlebar.fg_normal
		fg_normal = "#9ea3c0",
		-- alpha.titlebar.bg_focused
		bg_focused = "#545c8c",
		-- alpha.titlebar.fg_focused
		fg_focused = "#9ea3c0",
	}
}

-- Bravo Theme Settings
theme.bravo = {
	bar = {
		-- bravo.bar.font
		font = "Sarasa Mono CL 10",
		-- bravo.bar.bg
		bg = "#222433",
		-- bravo.bar.fg
		fg = "#9ea3c0",
		-- bravo.bar.sep_fg
		sep_fg = "#363e7f",
		-- bravo.bar.label_fg
		label_fg = "#929be5",
		-- bravo.bar.focused_tag_fg
		focused_tag_fg = "#929be5",
		-- bravo.bar.occupied_tag_fg
		occupied_tag_fg = "#a8a384",
		-- bravo.bar.empty_tag_fg
		empty_tag_fg = "#545c8c",
		-- bravo.bar.muted_fg
		muted_fg = "#73c1a9",
	}
}
theme.bar = "bravo"
theme.titlebar = "none"

return theme
