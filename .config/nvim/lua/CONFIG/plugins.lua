-- Install packer if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim "..install_path)
	vim.cmd "packadd packer.nvim"
end

vim.cmd "packadd packer.nvim"

return require("packer").startup(function(use)
	-- Lua Plugin Manager
	use { "wbthomason/packer.nvim", opt = true }

	-- Color Schemes
	use "SenorCornflake/vim-base16-colorschemes"
	use "wadackel/vim-dogrun"
	use "challenger-deep-theme/vim"
	use "arcticicestudio/nord-vim"
	use "ayu-theme/ayu-vim"
	use "cocopon/iceberg.vim"


	-- Highlighting
	use "nvim-treesitter/nvim-treesitter"

	-- Auto Pairs
	use "jiangmiao/auto-pairs"

	-- Lsp
	use "neovim/nvim-lspconfig"
	--use "glepnir/lspsaga.nvim"

	-- Fuzzy picker
	use "nvim-telescope/telescope.nvim"

	-- Required by telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'

	-- File manager
	use 'kevinhwang91/rnvimr'

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
end)
