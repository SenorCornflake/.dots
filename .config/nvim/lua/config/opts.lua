-- Global
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.updatetime = 300
vim.o.completeopt = "menuone,noselect"
vim.o.showmode = false
-- Had to repeat these as global for some reason
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.undofile = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Buffer Local
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.undofile = true
vim.bo.smartindent = true
vim.bo.autoindent = true

-- Window local
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.scrolloff = 8
vim.wo.sidescrolloff = 8
vim.wo.signcolumn = "yes"
vim.wo.cursorline = true
vim.wo.wrap = false
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

local colorscheme = "base16-pico"

vim.api.nvim_command("colorscheme "..colorscheme)
