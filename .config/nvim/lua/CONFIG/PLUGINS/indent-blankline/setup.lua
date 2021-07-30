local util = require "CONFIG.util"

--vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_char = "|"
vim.g.indent_blankline_space_char = " "
vim.g.indent_blankline_use_treesitter = false
vim.g.indent_blankline_show_end_of_line = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_filetype_exclude = {
	"help",
	"dashboard",
	"vista_kind",
	"Outline"
}

SetupIndentBlanklineHighlights = function()
	local char = util.get_color(
		{
			{ "Comment", "fg" }
		},
		{
			cterm = "2",
			gui = "#333333"
		}
	)
	local context_char = util.get_color(
		{
			{ "Normal", "fg" }
		},
		{
			cterm = "7",
			gui = "#dddddd"
		}
	)

	vim.cmd("hi IndentBlanklineContextChar guifg=" .. context_char.gui .. " ctermfg=" .. context_char.cterm)
	vim.cmd("hi IndentBlanklineChar guifg=" .. char.gui .. " ctermfg=" .. char.cterm)
end

vim.cmd "autocmd ColorScheme * lua SetupIndentBlanklineHighlights()"
