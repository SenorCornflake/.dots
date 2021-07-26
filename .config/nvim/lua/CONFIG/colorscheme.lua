local util = require("CONFIG.util")

local colorscheme = "deep-space"

vim.g.gruvbox_contrast_dark = "hard"

local reload_colorscheme = function()
	if colorscheme == "NONE" then
		require "CONFIG.PLUGINS.nvim-base16.setup"
	else
		vim.cmd("colorscheme " .. colorscheme)
	end
end

local layout = util.capture("cat ~/MAIN/tmp/current_layout.txt")

if colorscheme == "base16-schemer2" or layout == "do-you-even-luft.sh" then
	vim.cmd ":hi clear LineNr"
	vim.cmd ":hi clear SignColumn"
	vim.cmd ":hi link LineNr Comment"

	vim.cmd "augroup SETUP_SIDES"
	vim.cmd "autocmd VimEnter,ColorScheme * hi clear LineNr"
	vim.cmd "autocmd VimEnter,ColorScheme * hi clear SignColumn"
	vim.cmd "autocmd VimEnter,ColorScheme * hi link LineNr Comment"
	vim.cmd "augroup END"
else
	vim.cmd "silent! autocmd! SETUP_SIDES"
	reload_colorscheme()
end

-- Setup LSP colors
local lsp_test =  util.get_color({{"LspDiagnosticsDefaultError", "fg"}}, {
	cterm = false,
	gui = false
})

if not lsp_test.gui and not lsp_test.cterm then
	local bg = util.get_color(
		{
			{ "SignColumn", "bg" },
			{ "Normal", "bg" }
		},
		{
			cterm = "0",
			gui = "#000000"
		}
	)
	local error = util.get_color(
		{
			{ "ErrorMsg", "fg" }
		},
		{
			cterm = "0",
			gui = "#000000"
		}
	)
	local warn = util.get_color(
		{
			{ "Constant", "fg" },
			{ "WarningMsg", "fg"  },
			{ "Boolean", "fg" },
			{ "Delimiter", "fg" }
		},
		{
			cterm = "0",
			gui = "#000000"
		}
	)
	local hint = util.get_color(
		{
			{ "Special", "fg" },
			{ "Function", "fg" },
			{ "Include", "fg" }
		},
		{
			cterm = "0",
			gui = "#000000"
		}
	)
	local info = util.get_color(
		{
			{ "String", "fg" },
			{ "DiffAdded", "fg" },
			{ "DiffAdd", "fg" },
		},
		{
			cterm = "0",
			gui = "#000000"
		}
	)

	vim.cmd "augroup LSP_SETUP_HIGHLIGHTS"
	vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultError guifg=" .. error.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. error.cterm .. " ctermbg=" .. bg.cterm)
	vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultWarning guifg=" .. warn.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. warn.cterm .. " ctermbg=" .. bg.cterm)
	vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultInformation guifg=" .. info.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. info.cterm .. " ctermbg=" .. bg.cterm)
	vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultHint guifg=" .. hint.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. hint.cterm .. " ctermbg=" .. bg.cterm)
	vim.cmd "augroup END"
else
	vim.cmd "silent! autocmd! LSP_SETUP_HIGHLIGHTS"
	reload_colorscheme()
end

