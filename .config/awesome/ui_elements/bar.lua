-- Seperate file for setting up bar
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local util = require("util")

local M = {}

local bars = {}
-- Get all files in bars directory
local files = util.scandir(gears.filesystem.get_configuration_dir() .. "ui_elements/bars")

-- Remove .lua from the filenames and add the required bar to the bars table
for _, file in pairs(files) do
	file = file:gsub(".lua", "")
	bars[file] = require("ui_elements.bars." .. file)
end

function M.use(bar)
	if bars[bar] == nil then
		return nil
	end
	bars[bar].setup()
end

return M
