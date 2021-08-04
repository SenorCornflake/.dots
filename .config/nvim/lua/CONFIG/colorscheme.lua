local util = require("CONFIG.util")

-- Exconman manages the value of this variable
local colorscheme = "base16"

-- Use base16 theme if it's set to base16
if colorscheme == "base16" then
	require "CONFIG.PLUGINS.nvim-base16.setup"
else
	vim.cmd("colorscheme " .. colorscheme)
end
