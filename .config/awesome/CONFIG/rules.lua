local awful = require "awful"
local theme = require "CONFIG.theme"

awful.rules.rules = {
	{
		rule = { },
		properties = {
			border_width = theme.general_borderWidth,
			border_color = theme.general_borderNormal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = _G.bindings.client_keys,
			buttons = _G.bindings.client_buttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		}
	},
	{
		rule_any = {
			type = {"dialog"}
		},
		properties = {
			ontop = true,
			floating = true
		}
	},
	{
		rule_any = {
			type = {"normal", "dialog"}
		},
		properties = {
			titlebars_enabled = true,
		}
	},
	{ -- Fix firefox always floating, I never used to have this issue, but it happened suddenly and I don't know why
		rule = {
			class = "firefox",
		},
		properties = {
			floating = false,
			maximized = false
		}
	}
}
