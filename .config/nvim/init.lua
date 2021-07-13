for k, _ in pairs(package.loaded) do
	if string.match(k, "^CONFIG") then
		package.loaded[k] = nil
	end
end


vim = vim -- Less "undefined global" warnings this way

local colorscheme = "oceanic_material"
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

-------------
-- Plugins --
-------------
--require "CONFIG.PLUGINS.treesitter" -- Treesitter's indenting is horrific
require "CONFIG.PLUGINS.autopairs"
--require "CONFIG.PLUGINS.rnvimr"
require "CONFIG.PLUGINS.telescope"
require "CONFIG.PLUGINS.vista"
require "CONFIG.PLUGINS.compe"
require "CONFIG.PLUGINS.lspkind"
require "CONFIG.PLUGINS.rooter"
require "CONFIG.PLUGINS.gitsigns"
require "CONFIG.PLUGINS.buftabline"
require "CONFIG.PLUGINS.hexokinase"
require "CONFIG.PLUGINS.hop"
require "CONFIG.PLUGINS.whichkey"
require "CONFIG.PLUGINS.dashboard"
require "CONFIG.PLUGINS.floatterm"
require "CONFIG.PLUGINS.emmet"
require "CONFIG.PLUGINS.truezen"
require "CONFIG.PLUGINS.kommentary"
require "CONFIG.PLUGINS.trouble"
require "CONFIG.PLUGINS.polyglot"

vim.cmd "doautocmd User Restarted"
