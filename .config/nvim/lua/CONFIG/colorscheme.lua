return function (colorscheme)
	vim.cmd("colorscheme " .. colorscheme)

	-- vim.cmd ":hi clear LineNr"
	-- vim.cmd ":hi clear SignColumn"
	-- vim.cmd ":hi link LineNr Comment"
	vim.cmd ":hi Comment cterm=italic gui=italic"
	-- vim.cmd "autocmd VimEnter * hi clear LineNr"
	-- vim.cmd "autocmd VimEnter * hi clear SignColumn"
	-- vim.cmd "autocmd VimEnter * hi link LineNr Comment"
	vim.cmd "autocmd ColorScheme * hi Comment cterm=italic gui=italic"
end