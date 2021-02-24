for k, _ in pairs(package.loaded) do
	if string.match(k, "^config") then
		package.loaded[k] = nil
	end
end

require "config.kommentary"
require "config.plugins"
require "config.opts"
require "config.bindings"
require "config.lsp"
require "config.treesitter"
require "config.nvim_compe"
require "config.rnvimr"
require "config.rooter"
require "config.suda"
require "config.statusline"
