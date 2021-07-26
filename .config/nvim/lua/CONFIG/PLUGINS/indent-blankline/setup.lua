--vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_char = "|"
vim.g.indent_blankline_space_char = " "
vim.g.indent_blankline_use_treesitter = false
vim.g.indent_blankline_show_end_of_line = false
vim.g.indent_blankline_show_current_context = true

--ssssssssssssssss
vim.cmd "autocmd ColorScheme * hi link IndentBlanklineContextChar Normal"
vim.cmd "autocmd ColorScheme * hi link IndentBlanklineChar Comment"
