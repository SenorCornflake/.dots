local json = require "neovim_configuration.lib.json"
local util = require "neovim_configuration.util"

local base16 = io.open(os.getenv("DOT_ROOT") .. "/scripts/storage/base16.json", "r"):read()
base16 = json.decode(base16)

for k, v in pairs(base16) do
	if k:find("base") then
		base16[k] = "#" .. v
	end
end

vim.cmd "doautocmd ColorSchemePre"

require('base16-colorscheme').setup(base16)

if base16.scheme == "Generated" then
	local bg = util.get_color({{"Normal", "bg"}}).gui
	local linenr = util.get_color({{"LineNr", "fg"}}).gui

	if util.color_is_bright(bg, 0.5) then
		linenr = util.shade_color(linenr, 70)
	else
		linenr = util.shade_color(linenr, -50)
	end

	vim.cmd("hi LineNr guifg=" .. linenr)
end

vim.cmd "doautocmd ColorScheme"
