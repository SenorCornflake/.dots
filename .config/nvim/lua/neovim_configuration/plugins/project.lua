require "project_nvim".setup {
	manual_mode = true,
	detection_methods = { "pattern", "lsp" },
	patterns = { ".root", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
	show_hidden = true,
	silent_chdir = false,
	datapath = vim.fn.stdpath("data")
}
