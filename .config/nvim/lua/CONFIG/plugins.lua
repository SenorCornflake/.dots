-- Install packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim "..install_path)
	vim.cmd "packadd packer.nvim"
end

vim.cmd "packadd packer.nvim"

local util = require("CONFIG.util")

require("packer").startup(function(use)
	-- Lua Plugin Manager
	use {
		"wbthomason/packer.nvim",
		opt = false,
		config = function()
			require "CONFIG.PLUGINS.packer.bindings"
		end
	}

	local function color(repo)
		use {
			repo,
			-- cmd = "color",
			-- event = "ColorSchemePre"
		}
	end

	-- Color Schemes
	color "tomasiser/vim-code-dark"
	color "axvr/photon.vim"
	color "srcery-colors/srcery-vim"
	color "navarasu/onedark.nvim"
	color "haishanh/night-owl.vim"
	color "rafamadriz/neon"
	color 'yashguptaz/calvera-dark.nvim'
	color "sainnhe/everforest"
	color "yonlu/omni.vim"
	use {
		"folke/tokyonight.nvim",
		-- cmd = "color",
		-- event = "ColorSchemePre",
		opt = false,
		config = function()
			require "CONFIG.PLUGINS.tokyonight.setup"
		end
	}
	use {
		"Shatur/neovim-ayu",
		-- cmd = "color",
		-- event = "ColorSchemePre",
		opt = false,
		config = function()
			require "CONFIG.PLUGINS.nvim-ayu.setup"
		end
	} 

	-- Colorizor
	use {
		"RRethy/vim-hexokinase",
		run = "make hexokinase",
		ft = {
			"html",
			"css",
			"php",
			"javascript"
		},
		config = function()
			require "CONFIG.PLUGINS.hexokinase.setup"
		end
	}
	
	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require "CONFIG.PLUGINS.treesitter.setup"
		end
	}
	use {
		"JoosepAlviste/nvim-ts-context-commentstring",
	}
	use "windwp/nvim-ts-autotag"
	use {
		"haringsrob/nvim_context_vt",
		config = function()
			require "CONFIG.PLUGINS.nvim_context_vt.setup"
		end
	}

	-- Syntax
	use {
		"LnL7/vim-nix",
		ft = { "nix" }
	}
	use {
 		"fladson/vim-kitty",
		ft = { "kitty" }
	}

	-- Auto Pairs
	use "jiangmiao/auto-pairs"

	-- Lsp
	use {
		"neovim/nvim-lspconfig",
		opt = false
	}

	use {
		"simrat39/symbols-outline.nvim",
		config = function()
			require "CONFIG.PLUGINS.symbols-outline.setup"
			require "CONFIG.PLUGINS.symbols-outline.bindings"
		end
	}

	-- Fuzzy picker
	use {
		"nvim-telescope/telescope.nvim",
		config = function()
			require "CONFIG.PLUGINS.telescope.setup"
			require "CONFIG.PLUGINS.telescope.bindings"
		end
	}

	-- Required by telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

	-- File manager
	use 'kevinhwang91/rnvimr'
	use {
		'voldikss/vim-floaterm', -- for lf filemanager
		config = function()
			require "CONFIG.PLUGINS.floaterm.setup"
			require "CONFIG.PLUGINS.floaterm.bindings"
		end
	}

	-- Statusline builder
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
	}

	-- Icons for galaxyline
	use 'kyazdani42/nvim-web-devicons'

	-- Completion Menu
	use {
		'hrsh7th/nvim-compe',
		event = "InsertEnter",
		config = function()
			require "CONFIG.PLUGINS.compe.setup"
		end
	}

	-- Icons in completion menus
	use {
		'onsails/lspkind-nvim',
		event = "BufEnter",
		config = function()
			require "CONFIG.PLUGINS.lspkind.setup"
		end
	}

	-- Auto detect root
	use {
		'airblade/vim-rooter',
		config = function()
			require "CONFIG.PLUGINS.rooter.setup"
			require "CONFIG.PLUGINS.rooter.bindings"
		end
	}

	-- Git commands in vim
	use {
		'tpope/vim-fugitive',
		config = function()
			require "CONFIG.PLUGINS.fugitive.bindings"
		end
	}

	-- Git signs in gutter
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require "CONFIG.PLUGINS.gitsigns.setup"
		end
	}

	-- Buffer tab line
	use {
		"akinsho/nvim-bufferline.lua",
		config = function()
			require "CONFIG.PLUGINS.nvim-bufferline.setup"
		end
	}

	-- Surround
	use "tpope/vim-surround"

	-- Faster Movement
	use {
		"phaazon/hop.nvim",
		cmd = "HopChar1",
		config = function()
			require "CONFIG.PLUGINS.hop.setup"
			require "CONFIG.PLUGINS.hop.bindings"
		end
	}

	-- Keybinding visualizer
	use {
		"folke/which-key.nvim",
		config = function()
			require "CONFIG.PLUGINS.whichkey.setup"
		end
	}

	-- Dashboard
	use {
		"glepnir/dashboard-nvim",
		setup = function()
			require "CONFIG.PLUGINS.dashboard.setup"
		end,
		config = function()
			require "CONFIG.PLUGINS.dashboard.bindings"
		end
	}


	-- HTML expander
	use {
		"mattn/emmet-vim",
		config = function()
			require "CONFIG.PLUGINS.emmet.setup"
		end
	}

	-- Comment Code
	use {
		"b3nj5m1n/kommentary",
		config = function()
			require "CONFIG.PLUGINS.kommentary.setup"
			require "CONFIG.PLUGINS.kommentary.bindings"
		end
	}

	-- Bottom lister
	use {
		"folke/trouble.nvim",
		cmd = {
			"Trouble",
			"TroubleToggle"
		},
		config = function()
			require "CONFIG.PLUGINS.trouble.setup"
			require "CONFIG.PLUGINS.trouble.bindings"
		end
	}

	-- Smooth scroll
	use {
		"karb94/neoscroll.nvim",
		event = "BufEnter",
		config = function()
			require "CONFIG.PLUGINS.neoscroll.setup"
		end,
	}

	use "dstein64/vim-startuptime"
end)
