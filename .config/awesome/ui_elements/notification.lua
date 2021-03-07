-- Seperate file for notification
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local util = require("util")

local notification = {}

function notification.use(n)
	require("ui_elements.notifications." .. n).setup()
end

return notification
