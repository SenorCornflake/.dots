local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	vim.api.nvim_command('packadd packer.nvim')
end

vim.api.nvim_command("packadd packer.nvim")


return require('packer').startup(function()
	use { 'wbthomason/packer.nvim', opt = true }
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'SenorCornflake/vim-base16-colorschemes'
	use 'kevinhwang91/rnvimr'
	use 'nvim-lua/popup.nvim' -- Required by telescope
	use 'nvim-lua/plenary.nvim' -- Required by telescope
	use 'nvim-telescope/telescope.nvim'
	use 'airblade/vim-rooter'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-lua/lsp_extensions.nvim'
	use 'mattn/emmet-vim'
	use 'psliwka/vim-smoothie'
	use 'tpope/vim-fugitive'
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'
	-- Remember hyperstyle
end)

