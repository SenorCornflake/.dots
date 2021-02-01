for k, _ in pairs(package.loaded) do
	if string.match(k, "^config") then
		package.loaded[k] = nil
	end
end

require "config.plugins"
require "config.opts"
require "config.bindings"
require "config.lsp"
require "config.treesitter"
require "config.completion"
require "config.rnvimr"
require "config.rooter"
require "config.statusline"
