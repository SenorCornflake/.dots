-- Global
vim.o.hidden = true
vim.o.termguicolors = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.updatetime = 300
vim.o.completeopt = "menuone,noselect"
vim.o.showmode = false
vim.o.clipboard = "unnamedplus"

-- Had to repeat these as global
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
vim.wo.foldmethod = "syntax"
--vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.php_folding = 2

local colorscheme = "base16-material-vivid"

vim.api.nvim_command("colorscheme "..colorscheme)

vim.cmd(":hi clear LineNr")
vim.cmd(":hi clear SignColumn")
vim.cmd(":hi link LineNr Comment")
vim.cmd("autocmd VimEnter * hi clear LineNr")
vim.cmd("autocmd VimEnter * hi clear SignColumn")
vim.cmd("autocmd VimEnter * hi link LineNr Comment")
