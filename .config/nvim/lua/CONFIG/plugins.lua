-- Install packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim "..install_path)
	vim.cmd "packadd packer.nvim"
end

vim.cmd "packadd packer.nvim"

local util = require("CONFIG.util")

require("packer").startup(function(use)
	-- Lua Plugin Manager
	use { "wbthomason/packer.nvim", opt = true }

	-- Color Schemes
	use "tomasiser/vim-code-dark"
	use "axvr/photon.vim"
	use "srcery-colors/srcery-vim"
	use "navarasu/onedark.nvim"
	use "haishanh/night-owl.vim"
	use "rafamadriz/neon"
	use "SenorCornflake/nvim-base16"
	use 'yashguptaz/calvera-dark.nvim'
	use "sainnhe/everforest"
	use "folke/tokyonight.nvim"

	-- Colorizor
	use {
		"RRethy/vim-hexokinase",
		run = "make hexokinase"
	}

	-- Indent marks
	use "lukas-reineke/indent-blankline.nvim"

	-- Treesitter
	use "nvim-treesitter/nvim-treesitter"
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use "windwp/nvim-ts-autotag"
	use "haringsrob/nvim_context_vt"

	-- Syntax
	use "LnL7/vim-nix"
	use "fladson/vim-kitty"

	-- Highlight word under cursor
	--use "yamatsum/nvim-cursorline"

	-- Auto Pairs
	use "jiangmiao/auto-pairs"

	-- Lsp
	use "neovim/nvim-lspconfig"
	use "simrat39/symbols-outline.nvim"
	--use 'liuchengxu/vista.vim'

	-- Fuzzy picker
	use "nvim-telescope/telescope.nvim"

	-- Required by telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

	-- File manager
	use 'kevinhwang91/rnvimr'
	use 'voldikss/vim-floaterm' -- for lf filemanager


	-- Statusline builder
	use {
		'glepnir/galaxyline.nvim',
		branch = 'main',
	}

	-- Icons for galaxyline
	use 'kyazdani42/nvim-web-devicons'

	-- Completion Menu
	use 'hrsh7th/nvim-compe'

	-- Icons in completion menus
	use 'onsails/lspkind-nvim'

	-- Auto detect root
	use 'airblade/vim-rooter'

	-- Git commands in vim
	use 'tpope/vim-fugitive'

	-- Git signs in gutter
	use 'lewis6991/gitsigns.nvim'

	-- Buffer tab line
	--use "jose-elias-alvarez/buftabline.nvim"
	use "akinsho/nvim-bufferline.lua"

	-- Surround
	use "tpope/vim-surround"

	-- Faster Movement
	use "phaazon/hop.nvim"

	-- Keybinding visualizer
	use "folke/which-key.nvim"

	-- Dashboard
	use "glepnir/dashboard-nvim"

	-- HTML expander
	use "mattn/emmet-vim"

	-- Zen mode
	use "Pocco81/TrueZen.nvim"

	-- Comment Code
	use "b3nj5m1n/kommentary"

	-- Bottom lister
	use {
		"folke/trouble.nvim"
	}

	-- Smooth scroll
	use "karb94/neoscroll.nvim"

	use "dstein64/vim-startuptime"
end)

-- Load all plugin configs
local plugin_configs = util.scandir("~/.config/nvim/lua/CONFIG/PLUGINS")

for i, config in pairs(plugin_configs) do
	local plugins_dir = util.expanduser("~/.config/nvim/lua/CONFIG/PLUGINS/")
	local filename = config:gsub(".lua", "")

	if util.isdir(plugins_dir .. config) then
		if util.file_exists(plugins_dir .. config .. "/setup.lua") then
			require("CONFIG.PLUGINS." .. filename .. ".setup")
		end
	else
		require ("CONFIG.PLUGINS." .. filename)
	end
end
