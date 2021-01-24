-- Launch default programs
local awful = require("awful")

local util = require("util")

local M = {}

function M.terminal()
	awful.spawn("alacritty")
end

function M.browser()
	awful.spawn("firefox")
end

function M.compositor()
	local pid = util.read_command("pgrep picom")

	-- Only start compositor if it's not already running
	if #pid == 0 then
		awful.spawn.with_shell("picom --experimental-backends &")
	end
end

return M
