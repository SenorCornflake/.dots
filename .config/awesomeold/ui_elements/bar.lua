-- Seperate file for setting up bar
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local util = require("util")

local bar = {}

function bar.use(b)
	require("ui_elements.bars." .. b).setup()
end

return bar
