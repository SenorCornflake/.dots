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
	--use "SenorCornflake/vim-base16-colorschemes"
	use "tomasiser/vim-code-dark"
	use "rafi/awesome-vim-colorschemes"
	use "axvr/photon.vim"
	use "srcery-colors/srcery-vim"
	use "navarasu/onedark.nvim"
	use "haishanh/night-owl.vim"

	-- Colorizor
	use {
		"RRethy/vim-hexokinase",
		run = "make hexokinase"
	}

	-- Highlighting
	use "nvim-treesitter/nvim-treesitter"
	--use "sheerun/vim-polyglot"
	use "LnL7/vim-nix" -- For nix config files
	use "fladson/vim-kitty"

	-- Auto Pairs
	use "jiangmiao/auto-pairs"

	-- Lsp
	use "neovim/nvim-lspconfig"

	-- Fuzzy picker
	use "nvim-telescope/telescope.nvim"

	-- Required by telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

	-- File manager
	use 'kevinhwang91/rnvimr'

	use 'voldikss/vim-floaterm'

	-- Symbol sidebar lister
	use 'liuchengxu/vista.vim'

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
	use "jose-elias-alvarez/buftabline.nvim"

	-- Surround
	use "tpope/vim-surround"

	-- Faster Movement
	use "phaazon/hop.nvim"

	-- Keybinding visualizer
	use "folke/which-key.nvim"

	-- Dashboard
	use "glepnir/dashboard-nvim"

	-- HTML auto thingy
	use "mattn/emmet-vim"

	-- Zen mode
	use "Pocco81/TrueZen.nvim"

	-- Comment Code
	use "b3nj5m1n/kommentary"

	-- LSP Highlights
	-- use "folke/lsp-colors.nvim"

	-- Bottom lister
	use "folke/trouble.nvim"

	-- Smooth scroll
	use "karb94/neoscroll.nvim"
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
