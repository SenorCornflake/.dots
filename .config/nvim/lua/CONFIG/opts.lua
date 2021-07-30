local util = require("CONFIG.util")

vim.opt.hidden         = true 
vim.opt.termguicolors  = true 
vim.opt.hlsearch       = true 
vim.opt.incsearch      = true 
vim.opt.splitbelow     = true 
vim.opt.splitright     = true 
vim.opt.showmode       = false
vim.opt.updatetime     = 300
vim.opt.laststatus     = 2
vim.opt.clipboard      = "unnamedplus"
vim.opt.runtimepath    = vim.o.runtimepath .. "," .. "~/MAIN/tmp/vim_colors/"
vim.opt.foldmethod     = "syntax"
vim.opt.foldenable     = true

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.wrap           = false
vim.opt.scrolloff      = 4
vim.opt.sidescrolloff  = 8
vim.opt.signcolumn     = "yes"
vim.opt.mouse = "a"

vim.opt.undofile       = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = false

vim.cmd "autocmd FileType nix setlocal shiftwidth=2 tabstop=2 expandtab"
