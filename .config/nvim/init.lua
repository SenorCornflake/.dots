for k, _ in pairs(package.loaded) do
	if string.match(k, "^CONFIG") then
		package.loaded[k] = nil
	end
end


vim = vim -- Less "undefined global" warnings this way

local colorschemes = "base16-onedark"
local powerline_symbol = "up_slant"

-------------
-- General --
-------------
require 'CONFIG.plugins'
require 'CONFIG.opts'
require 'CONFIG.bindings'
require 'CONFIG.colorscheme'(colorschemes)
require "CONFIG.lsp"
require "CONFIG.statusline"(powerline_symbol)


-------------
-- Plugins --
-------------
require "CONFIG.PLUGINS.treesitter"
require "CONFIG.PLUGINS.autopairs"
require "CONFIG.PLUGINS.telescope"
require "CONFIG.PLUGINS.rnvimr"
require "CONFIG.PLUGINS.vista"
require "CONFIG.PLUGINS.compe"
require "CONFIG.PLUGINS.lspkind"
require "CONFIG.PLUGINS.rooter"
require "CONFIG.PLUGINS.gitsigns"
