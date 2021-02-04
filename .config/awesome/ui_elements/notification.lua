-- Seperate file for notification
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local util = require("util")

local M = {}

local notifications = {}
-- Get all files in bar directory
local files = util.scandir(gears.filesystem.get_configuration_dir() .. "ui_elements/notifications")

-- Remove .lua from the filenames and add the required notification to the notifications table
for _, file in pairs(files) do
	file = file:gsub(".lua", "")
	notifications[file] = require("ui_elements.notifications." .. file)
end

function M.use(notification)
	if notifications[notification] == nil then
		return nil
	end
	notifications[notification].setup()
end

return M
