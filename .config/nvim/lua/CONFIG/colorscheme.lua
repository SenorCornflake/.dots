return function (colorscheme)
	vim.g.onedark_style = "darker"

	vim.cmd("colorscheme " .. colorscheme)

	if colorscheme == "base16-schemer2" then
		vim.cmd ":hi clear LineNr"
		vim.cmd ":hi clear SignColumn"
		vim.cmd ":hi link LineNr Comment"
		vim.cmd "autocmd VimEnter,ColorScheme * hi clear LineNr"
		vim.cmd "autocmd VimEnter,ColorScheme * hi clear SignColumn"
		vim.cmd "autocmd VimEnter,ColorScheme * hi link LineNr Comment"
	end

	vim.cmd ":hi Comment cterm=italic gui=italic"
	vim.cmd "autocmd ColorScheme * hi Comment cterm=italic gui=italic"
end
