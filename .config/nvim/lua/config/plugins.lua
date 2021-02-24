local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	vim.api.nvim_command('packadd packer.nvim')
end

vim.api.nvim_command("packadd packer.nvim")


return require('packer').startup(function()
	use { 'wbthomason/packer.nvim', opt = true } -- Plugin Manager
	use 'neovim/nvim-lspconfig'                  -- LSP
	use 'nvim-lua/lsp_extensions.nvim'           -- Exra LSP Stuff
	use 'hrsh7th/nvim-compe'                     -- Completion
	use 'SenorCornflake/vim-base16-colorschemes' -- Colorschemes
	use 'kevinhwang91/rnvimr'                    -- Ranger File Manager
	use 'nvim-lua/popup.nvim'                    -- Required by telescope
	use 'nvim-lua/plenary.nvim'                  -- Required by telescope
	use 'nvim-telescope/telescope.nvim'          -- Fuzzy Finders
	use 'airblade/vim-rooter'                    -- Change root dir
	use 'nvim-treesitter/nvim-treesitter'        -- Better highlighting
	use 'mattn/emmet-vim'                        -- HTML Expansion
	use 'psliwka/vim-smoothie'                   -- Smooth Scrolling
	use 'tpope/vim-fugitive'                     -- Git integration
	use 'Konfekt/FastFold'                       -- Faster Folding (Specifically for PHP)
	use 'glepnir/galaxyline.nvim'                -- Status Line
	use 'onsails/lspkind-nvim'                   -- Completion Icons for LSP
	use 'b3nj5m1n/kommentary'                    -- Comment Plugin
	use 'kevinhwang91/nvim-bqf'                  -- Better Quickfix windows
	use 'norcalli/nvim-colorizer.lua'            -- Highlight Color Codes
	use {                                        -- Markdown file preview
		"npxbr/glow.nvim",                       --
		cmd = ":GlowInstall"                     --
	}                                            --
	use 'lambdalisue/suda.vim'                   -- Sudo write
	use 'tpope/vim-surround'                     -- Surround text objects
	-- Remember hyperstyle
end)

