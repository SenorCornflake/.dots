local util = require("CONFIG.util")

return function (colorscheme)
	vim.g.onedark_style = "darker"

	vim.cmd("colorscheme " .. colorscheme)

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
		vim.cmd("colorscheme " .. colorscheme)
	end

	vim.cmd ":hi Comment cterm=italic gui=italic"
	vim.cmd "autocmd VimEnter,ColorScheme * hi Comment cterm=italic gui=italic"
end
