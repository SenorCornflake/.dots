local util = require "neovim_configuration.util"

require("xplr").setup({
	ui = {
		border = {
			style = "single",
			highlight = "FloatBorder",
		},
		position = "30%",

		size = {
			width = "40%",
			height = "60%",
		},
	},
	previewer = {
		split = true,
		split_percent = 0.5,
		ui = {
			border = {
				style = "single",
				highlight = "FloatBorder",
			},
			position = { row = "1%", col = "99%" },
			relative = "editor", -- editor only supported for now
			size = {
				width = "30%",
				height = "99%",
			},
		},
	},
	xplr = {
		open_selection = {
			enabled = true,
			mode = "action",
			key = "o",
		},
		preview = {
			enabled = true,
			mode = "action",
			key = "i",
			fifo_path = "/tmp/nvim-xplr.fifo",
		},
		set_nvim_cwd = {
			enabled = true,
			mode = "action",
			key = "j",
		},
		set_xplr_cwd = {
			enabled = true,
			mode = "action",
			key = "h",
		},
	},
})


local opts = { noremap = true, silent = true }
local mappings = require("xplr.mappings")
local set_keymap = mappings.set_keymap
local on_previewer_set_keymap = mappings.on_previewer_set_keymap

util.map("n", "<space>x", '<Cmd>lua require"xplr".toggle()<CR>')
set_keymap("t", "<space>x", '<Cmd>lua require"xplr".toggle()<CR>')

on_previewer_set_keymap("t", "<space>xb", '<Cmd>lua require"xplr.actions".scroll_previewer_up()<CR>', opts)
on_previewer_set_keymap("t", "<space>xn", '<Cmd>lua require"xplr.actions".scroll_previewer_down()<CR>', opts)
