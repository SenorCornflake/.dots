-- Seperate file for titlebars
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local util = require("util")

local M = {}

local titlebars = {}
-- Get all files in bar directory
local files = util.scandir(gears.filesystem.get_configuration_dir() .. "ui_elements/titlebars")

-- Remove .lua from the filenames and add the required bar to the bars table
for _, file in pairs(files) do
	file = file:gsub(".lua", "")
	titlebars[file] = require("ui_elements.titlebars." .. file)
end

function M.use(titlebar)
	if titlebars[titlebar] == nil then
		return nil
	end
	titlebars[titlebar].setup()
end

return M
