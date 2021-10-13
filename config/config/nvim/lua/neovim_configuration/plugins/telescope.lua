local actions = require "telescope.actions"
-- local pickers = require "telescope.pickers"
-- local finders = require "telescope.finders"
-- local previewers = require "telescope.previewers"
-- local sorters = require "telescope.sorters"

require "telescope".setup {
	defaults = {
		layout_config = {
			horizontal = {
				width = 0.79,
				height = 0.93
			}
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				[":q<CR>"] = actions.close,
				["<M-q>"] = actions.close
			},
			n = {
				[":q<CR>"] = actions.close,
				["<M-q>"] = actions.close
			}
		}
	},
	pickers = {
		find_files = {
			hidden = true,
			follow = true,
			--theme = require('telescope.themes').get_dropdown({})qwertyuiopasdfghjklzxcvbnm,.qwertyuiop[asdfghjkl;zxcvbnm,]
		}
	},
}

vim.cmd "doautocmd User load_project_plugin"
require "telescope".load_extension("projects")
