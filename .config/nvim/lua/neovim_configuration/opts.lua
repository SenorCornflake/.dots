local opt = vim.opt

-- Pain incurs without these options
opt.hidden = true
opt.termguicolors = true opt.hlsearch = true
opt.incsearch = true
opt.splitbelow = true
opt.splitright = true

-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = false

-- Convenience
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.mouse = "a"
opt.undofile = true
opt.cursorline = true
opt.completeopt = "menuone,noinsert,noselect"
opt.inccommand = "nosplit"
opt.showmode = false
opt.runtimepath    = vim.o.runtimepath .. "," .. "~/MAIN/tmp/vim_colors/"

-- Buffer sides
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Speed
opt.lazyredraw = true
opt.updatetime = 300

-- Folds
opt.foldenable = true
opt.foldmethod = "syntax"
