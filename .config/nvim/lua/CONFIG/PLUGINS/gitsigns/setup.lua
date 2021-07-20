local util = require("CONFIG.util")

require('gitsigns').setup {
	signs = {
		add          = { hl = 'GitSignsAdd'   , text = '+' },
		change       = { hl = 'GitSignsChange', text = '~' },
		delete       = { hl = 'GitSignsDelete', text = '-' },
		topdelete    = { hl = 'GitSignsDelete', text = '^' },
		changedelete = { hl = 'GitSignsChange', text = '~' },

		-- add          = { hl = 'GitSignsAdd'   , text = '|' },
		-- change       = { hl = 'GitSignsChange', text = '|' },
		-- delete       = { hl = 'GitSignsDelete', text = '|' },
		-- topdelete    = { hl = 'GitSignsDelete', text = '|' },
		-- changedelete = { hl = 'GitSignsChange', text = '|' },

		-- add          = { hl = 'GitSignsAdd'   , text = '▌' },
		-- change       = { hl = 'GitSignsChange', text = '▌' },
		-- delete       = { hl = 'GitSignsDelete', text = '▌' },
		-- topdelete    = { hl = 'GitSignsDelete', text = '▌' },
		-- changedelete = { hl = 'GitSignsChange', text = '▌' },

		-- add          = { hl = 'GitSignsAdd'   , text = '│' },
		-- change       = { hl = 'GitSignsChange', text = '│' },
		-- delete       = { hl = 'GitSignsDelete', text = '│' },
		-- topdelete    = { hl = 'GitSignsDelete', text = '│' },
		-- changedelete = { hl = 'GitSignsChange', text = '│' },
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

Setup_Gitsigns = function()
	local sign_bg = util.get_color(
		{
			{ "SignColumn", "bg" },
			{ "Normal", "bg" }
		}
	)

	local add_fg = util.get_color(
		{
			{ "DiffAdded", "fg" },
			{ "DiffAdd", "fg" },
			{ "MoreMsg", "fg" },
		}
	)

	local delete_fg = util.get_color(
		{
			{ "ErrorMsg", "fg" }
		}
	)

	local change_fg = util.get_color(
		{
			{ "Include", "fg" },
			{ "Function", "fg" },
			{ "Conditional", "fg" },
			{ "Keyword", "fg" },
		}
	)

	vim.cmd("hi clear GitSignsAdd")
	vim.cmd("hi clear GitSignsDelete")
	vim.cmd("hi clear GitSignsChange")

	vim.cmd("hi GitSignsAdd guibg="    .. sign_bg.gui .. " ctermbg=" .. sign_bg.cterm .. " guifg=" .. add_fg.gui    .. " ctermfg=" .. add_fg.cterm)
	vim.cmd("hi GitSignsDelete guibg=" .. sign_bg.gui .. " ctermbg=" .. sign_bg.cterm .. " guifg=" .. delete_fg.gui .. " ctermfg=" .. delete_fg.cterm)
	vim.cmd("hi GitSignsChange guibg=" .. sign_bg.gui .. " ctermbg=" .. sign_bg.cterm .. " guifg=" .. change_fg.gui .. " ctermfg=" .. change_fg.cterm) 
end

vim.cmd "autocmd VimEnter,ColorScheme * lua Setup_Gitsigns()"
