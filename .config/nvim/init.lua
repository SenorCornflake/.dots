for k, _ in pairs(package.loaded) do
	if string.match(k, "^CONFIG") then
		package.loaded[k] = nil
	end
end


vim = vim -- Less "undefined global" warnings this way

local colorscheme = "base16-synth-midnight-dark"
local powerline_symbol = "up_slant"

-------------
-- General --
-------------
require 'CONFIG.plugins'
require 'CONFIG.opts'
require 'CONFIG.bindings'
require 'CONFIG.colorscheme'(colorscheme)
require "CONFIG.lsp"
require "CONFIG.statusline"(powerline_symbol)

vim.cmd "doautocmd User Restarted"
