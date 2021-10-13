require "nvim-treesitter.configs".setup {
	ensure_installed = "all",
	highlight = {
		enable = true,
		-- Keeps old indenting
		additional_vim_regex_highlighting = true
	},
	indent = {
		enable = false
	}
}
