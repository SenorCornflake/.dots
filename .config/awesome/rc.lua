local awful = require "awful"

local theme = require "CONFIG.theme"
theme.init()
local session = require "CONFIG.session"
local util = require "CONFIG.util"

require "awful.autofocus"

_G.ICAO_CODE = "FACT"
_G.WIFI_INTERFACE = "wlan0"

_G.programs = require "CONFIG.programs"
_G.bindings = require "CONFIG.bindings"

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	--awful.layout.suit.floating
}

require "CONFIG.rules"
require "CONFIG.client"
require "CONFIG.tag"
require("CONFIG.BAR." .. theme.general_bar)
require("CONFIG.TITLEBAR." .. theme.general_titlebar)
util.set_wallpaper()

session.load()
