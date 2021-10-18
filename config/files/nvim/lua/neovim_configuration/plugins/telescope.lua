local actions = require "telescope.actions"

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

require "telescope".load_extension("projects")


local actions = require "telescope.actions"

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
				["<M-q>"] = actions.close
			},
			n = {
				["<M-q>"] = actions.close
			}
		}
	},
}
