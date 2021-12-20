local json = require "neovim_configuration.lib.json"

local base16 = io.open(os.getenv("DOT_ROOT") .. "/scripts/storage/base16.json", "r"):read()
base16 = json.decode(base16)

for k, v in pairs(base16) do
	base16[k] = "#" .. v
end

vim.cmd "doautocmd ColorSchemePre"

require('base16-colorscheme').setup(base16)

vim.cmd "doautocmd ColorScheme"
