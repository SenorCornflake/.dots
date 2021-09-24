local actions = require "fzf-lua.actions"

require "fzf-lua".setup {
	fzf_layout = "default",
	fzf_bin = "fzf",
	winopts = {
		win_width = 0.79,
		win_height = 0.89,
		win_row = 0.30,
		win_col = 0.50,
		win_border       = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
		hl_fzfBorder = "TelescopeBorder",
	},
	previewers = {
		bat = {
			cmd = "bat",
			args = "--style=numbers,changes --color always",
			theme = "base16",
			config = nil
		}
	},
	files = {
		prompt = " Files > ",
		cmd = "rg --hidden --follow --no-ignore --files -g '!.git/' -g '!node_modules/' -g '!target/' .",
		git_icons = true,
		file_icons = true,
		color_icons = true,
		previewer = "bat"
	},
	grep = {
		prompt            = ' Livegrep RG > ',
		input_prompt      = ' Grep for > ',
		rg_opts = "--hidden --follow --no-ignore --color=always --line-number --smart-case --no-heading --column -g '!.git/' -g '!node_modules/' -g '!target/'",
		git_icons         = true,           -- show git icons?
		file_icons        = true,           -- show file icons?
		color_icons       = true,           -- colorize file|git icons
		previewer = "bat",
		actions = {
			["default"]     = actions.file_edit,
			["ctrl-s"]      = actions.file_split,
			["ctrl-v"]      = actions.file_vsplit,
			["ctrl-t"]      = actions.file_tabedit,
			["ctrl-q"]      = actions.file_sel_to_qf,
			["ctrl-y"]      = function(selected) print(selected[2]) end,
		}
	},
}

vim.cmd "autocmd FileType fzf tnoremap <silent> <buffer> <M-q> <C-\\><C-n>:q<CR>"
