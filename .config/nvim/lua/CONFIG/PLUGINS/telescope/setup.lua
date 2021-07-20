
local util = require("CONFIG.util")
local actions = require('telescope.actions')

require "telescope".setup {
	defaults = {
		file_ignore_patterns = {"target/", "node_modules/", ".git/"},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				[":q<CR>"] = actions.close
			},
			n = {
				[":q<CR>"] = actions.close
			}
		}
	}
}

-- local foreground = util.gh("Keyword")

-- vim.cmd ("autocmd ColorScheme * hi TelescopeBorder         guifg=" .. foreground.guifg .. " ctermfg=" .. foreground.ctermfg)
-- vim.cmd ("autocmd ColorScheme * hi TelescopePromptBorder   guifg=" .. foreground.guifg .. " ctermfg=" .. foreground.ctermfg)
-- vim.cmd ("autocmd ColorScheme * hi TelescopeResultsBorder  guifg=" .. foreground.guifg .. " ctermfg=" .. foreground.ctermfg)
-- vim.cmd ("autocmd ColorScheme * hi TelescopePreviewBorder  guifg=" .. foreground.guifg .. " ctermfg=" .. foreground.ctermfg)

