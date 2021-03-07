-- Seperate file for titlebars
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local util = require("util")

local titlebar = {}

function titlebar.use(t)
	require("ui_elements.titlebars." .. t).setup()
end

return titlebar
