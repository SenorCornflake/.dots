require "nvim-treesitter.configs".setup {
	ensure_installed = {},
	highlight = {
		enable = true,
		-- Keeps old indenting
		additional_vim_regex_highlighting = false
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enabled = true;
		keymaps = {
		  init_selection = "gnn",
		  node_incremental = "grn",
		  scope_incremental = "grc",
		  node_decremental = "grm",
		},
	},
}
