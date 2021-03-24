local util = require("CONFIG.util")

vim.g.mapleader = " "

-------------
-- GENERAL --
-------------
-- Easy normal mode
util.bind("i", "kj", "<Esc>")

-- Better split navigation
util.bind("n", "<C-h>", "<C-w>h")
util.bind("n", "<C-j>", "<C-w>j")
util.bind("n", "<C-k>", "<C-w>k")
util.bind("n", "<C-l>", "<C-w>l")

-- Better writing
util.bind("n", "<leader>w", ":w<CR>")

-- Use tab in popup menus
util.bind('i', '<Tab>'  , 'pumvisible() ? "<C-n>" : "<Tab>"'  , { expr = true, noremap = true, silent = true })
util.bind('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, noremap = true, silent = true })

-- Reload neovim
util.bind("n", "<leader>,", ":luafile ~/.config/nvim/init.lua<CR>")


---------
-- LSP --
---------
-- util.bind("n", "<leader>ld", ":Lspsaga lsp_finder<CR>")
-- util.bind("n", "<leader>lS", ":Lspsaga signature_help<CR>")
-- util.bind("n", "<leader>lh", ":Lspsaga hover_doc<CR>")
-- util.bind("n", "<leader>la", ":Lspsaga code_action<CR>")
-- util.bind("n", "<leader>lA", ":Lspsaga range_code_action<CR>")
-- util.bind("n", "<leader>lr", ":Lspsaga rename<CR>")
-- util.bind("n", "<leader>ld", ":Lspsaga show_line_diagnostics<CR>")

util.bind('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>')
util.bind('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<cr>')
util.bind('n', '<leader>li', ':lua vim.lsp.buf.implementation()<cr>')
util.bind('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<cr>')
util.bind('n', '<leader>lk', ':lua vim.lsp.buf.hover()<cr>')
util.bind('n', '<leader>lr', ':lua vim.lsp.buf.rename()<cr>')
util.bind('n', '<leader>lR', ':lua vim.lsp.buf.references()<cr>')
util.bind('n', '<leader>le', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
util.bind('n', '<leader>lh', ':lua require("lsp_extensions").inlay_hints()<cr>')

---------------
-- Telescope --
---------------
util.bind("n", "<leader>f.", ":Telescope builtin<CR>")
util.bind("n", "<leader>ff", ":Telescope find_files<CR>")
util.bind("n", "<leader>fg", ":Telescope live_grep<CR>")
util.bind("n", "<leader>fb", ":Telescope buffers<CR>")
util.bind("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>")
util.bind("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>")
util.bind("n", "<leader>fr", ":Telescope lsp_references<CR>")

------------
-- RnvimR --
------------
util.bind("n", "<leader>e", ":RnvimrToggle<CR>")

-----------
-- Vista --
-----------
util.bind("n", "<leader>v", ":Vista!!<CR>")

------------
-- Rooter --
------------
util.bind("n", "<leader>.", ":Rooter<CR>")

--------------
-- Fugitive --
--------------
util.bind("n", "<leader>gc", ":Git commit<CR>")
util.bind("n", "<leader>ga", ":Git add ", { noremap = true, silent = false })
util.bind("n", "<leader>gp", ":Git push<CR>")
util.bind("n", "<leader>gP", ":Git pull<CR>")
util.bind("n", "<leader>gb", ":Git blame<CR>")
util.bind("n", "<leader>gl", ":Git log<CR>")

----------------------------
-- Color Scheme Switching --
----------------------------
util.bind("n", "<Left>", ":lua require('CONFIG.util').next_colorscheme(true)<CR>")
util.bind("n", "<Right>", ":lua require('CONFIG.util').next_colorscheme(false)<CR>")
