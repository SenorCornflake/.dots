local actions = require "fzf-lua.actions"

require "fzf-lua".setup {
	winopts = {
		win_width = 0.79,
		win_height = 0.89,
		win_row = 0.30,
		win_col = 0.50,
		win_border       = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
		hl_fzfBorder = "TelescopeBorder",
	},
	grep = {
		prompt            = 'Rg❯ ',
		input_prompt      = 'Grep For❯ ',
		-- cmd               = "rg --vimgrep",
		rg_opts           = "--hidden --column --line-number --no-heading " ..
							"--color=always --smart-case -g '!{.git,node_modules,target}/*'",
		git_icons         = true,           -- show git icons?
		file_icons        = true,           -- show file icons?
		color_icons       = true,           -- colorize file|git icons
		-- 'true' enables file and git icons in 'live_grep'
		-- degrades performance in large datasets, YMMV
		experimental      = false,
		-- live_grep_glob options
		glob_flag         = "--iglob",  -- for case sensitive globs use '--glob'
		glob_separator    = "%s%-%-"    -- query separator pattern (lua): ' --'
	},
}

vim.cmd "autocmd FileType fzf tnoremap <silent> <buffer> <M-q> <C-\\><C-n>:q<CR>"


local actions = require "fzf-lua.actions"

require "fzf-lua".setup {
	winopts = {
		win_width = 0.79,
		win_height = 0.89,
		win_row = 0.30,
		win_col = 0.50,
		win_border       = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
		hl_fzfBorder = "TelescopeBorder",
	},
}

vim.cmd "autocmd FileType fzf tnoremap <silent> <buffer> <M-q> <C-\\><C-n>:q<CR>"
