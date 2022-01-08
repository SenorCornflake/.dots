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
	local visual = util.get_color({{"Visual", "bg"}}).gui
	local cursorline = visual

	if bg ~= nil and linenr ~= nil and visual ~= nil and os.getenv("TERM") ~= "linux" then -- If running in tty
		if util.color_is_bright(bg, 0.5) then
			print("Adjusting colors for light colorscheme")
			linenr = util.shade_color(linenr, 70)
			visual = util.shade_color(visual, 30)
			cursorline = util.shade_color(cursorline, 40)
		else
			print("Adjusting colors for dark colorscheme")
			linenr = util.shade_color(linenr, -50)
			visual = util.shade_color(visual, -40)
			cursorline = util.shade_color(cursorline, -50)
		end

		vim.cmd("hi LineNr guifg=" .. linenr)
		vim.cmd("hi Visual guibg=" .. visual)
		vim.cmd("hi CursorLine guibg=" .. cursorline)
		vim.cmd("hi CursorLineNr guibg=" .. cursorline)
	end

end

vim.cmd "doautocmd ColorScheme"
