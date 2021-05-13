local util = require("CONFIG.util")

require('gitsigns').setup {
	signs = {
		add          = { hl = 'GitSignsAdd'   , text = '+' },
		change       = { hl = 'GitSignsChange', text = '~' },
		delete       = { hl = 'GitSignsDelete', text = '-' },
		topdelete    = { hl = 'GitSignsDelete', text = '^' },
		changedelete = { hl = 'GitSignsChange', text = '~' },
	},
	numhl = false,
	linehl = false,
	-- keymaps = {
	-- 	-- Default keymap options
	-- 	noremap = true,
	-- 	buffer = true,

	-- 	['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
	-- 	['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

	-- 	['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
	-- 	['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
	-- 	['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
	-- 	['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
	-- 	['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
	-- 	['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

	-- 	-- Text objects
	-- 	['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
	-- 	['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
	-- },
	watch_index = {
		interval = 1000
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	use_decoration_api = true,
	use_internal_diff = true,  -- If luajit is present
}

SetGitSignHighlights = function()
	local sign_bg = util.gh("SignColumn")

	if vim.g.colors_name == "base16-schemer2" then
		sign_bg = util.gh("Normal")
	end

	local add = util.gh("String")
	local delete = util.gh("ErrorMsg")
	local change = util.gh("Include")

	if add then vim.cmd("hi GitSignsAdd guibg=" .. sign_bg.guibg .. " ctermbg=" .. sign_bg.ctermbg .. " guifg=" .. add.guifg .. " ctermfg=" .. add.ctermfg) end
	if delete then vim.cmd("hi GitSignsDelete guibg=" .. sign_bg.guibg .. " ctermbg=" .. sign_bg.ctermbg .. " guifg=" .. delete.guifg .. " ctermfg=" .. delete.ctermfg) end
	if change then vim.cmd("hi GitSignsChange guibg=" .. sign_bg.guibg .. " ctermbg=" .. sign_bg.ctermbg .. " guifg=" .. change.guifg .. " ctermfg=" .. change.ctermfg) end
end

vim.cmd "autocmd ColorScheme * :lua SetGitSignHighlights()"
