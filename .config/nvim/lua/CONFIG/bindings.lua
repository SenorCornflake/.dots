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
util.bind('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>')
util.bind('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<cr>')
util.bind('n', '<leader>li', ':lua vim.lsp.buf.implementation()<cr>')
util.bind('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<cr>')
util.bind('n', '<leader>lk', ':lua vim.lsp.buf.hover()<cr>')
util.bind('n', '<leader>lr', ':lua vim.lsp.buf.rename()<cr>')
util.bind('n', '<leader>lR', ':lua vim.lsp.buf.references()<cr>')
util.bind('n', '<leader>le', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
util.bind('n', '<leader>lh', ':lua require("lsp_extensions").inlay_hints()<cr>')

-------------
-- Buffers --
-------------
util.bind('n', '<leader>bd', ':bd<CR>')
util.bind('n', '<leader>bD', ':bd!<CR>')


---------------
-- Telescope --
---------------
util.bind("n", "<leader>f.", ":Telescope builtin<CR>")
util.bind("n", "<leader>ff", ":Telescope find_files<CR>")
util.bind("n", "<leader>fF", ":Telescope file_browser<CR>")
util.bind("n", "<leader>fg", ":Telescope live_grep<CR>")
util.bind("n", "<leader>fb", ":Telescope buffers<CR>")
util.bind("n", "<leader>fs", ":Telescope lsp_document_symbols<CR>")
util.bind("n", "<leader>fS", ":Telescope lsp_workspace_symbols<CR>")
util.bind("n", "<leader>fe", ":Telescope lsp_document_diagnostics<CR>")
util.bind("n", "<leader>fE", ":Telescope lsp_workspace_diagnostics<CR>")
util.bind("n", "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>")

------------
-- RnvimR --
------------
util.bind("n", "<leader>e", ":FloatermNew lf<CR>")

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

------------------------
-- Dashboard Sessions --
------------------------
util.bind("n", "<leader>sl", ":lua require('CONFIG.util').sessions()<cr>")
util.bind("n", "<leader>ss", ":SessionSave<CR>")

------------
-- Packer --
------------
util.bind("n", "<leader>ps", ":PackerSync<CR>")

-------------
-- TrueZen --
-------------
util.bind("n", "<leader>za", ":TZAtaraxis<CR>")
util.bind("n", "<leader>zf", ":TZFocus<CR>", { noremap = true, silent = false })
util.bind("n", "<leader>zm", ":TZMinimalist<CR>")

---------
-- Hop --
---------
util.bind("n", "s", ":HopChar1<CR>")

----------------
-- Kommentary --
----------------
util.bind("n", "<leader>cc", "<Plug>kommentary_line_default", { silent = true })
util.bind("n", "<leader>c", "<Plug>kommentary_motion_default", { silent = true })
util.bind("v", "<leader>c", "<Plug>kommentary_visual_default", { silent = true })

-------------
-- Trouble --
-------------
util.bind("n", "<leader>t", ":TroubleToggle<CR>")


----------------------------
-- Color Scheme Switching --
----------------------------
util.bind("n", "<Left>", ":lua require('CONFIG.util').next_colorscheme(true)<CR>")
util.bind("n", "<Right>", ":lua require('CONFIG.util').next_colorscheme(false)<CR>")

----------------------------------
-- Display highlight group name --
----------------------------------
util.bind("n", "<CR>", ":call SynStack()<CR>")

----------------------------------------------
-- Generate base16 theme from active scheme --
----------------------------------------------
vim.cmd "command! Base16ify lua print(require('CONFIG.util').base16ify())"

-----------------------------------
-- Adapt system to current theme --
-----------------------------------
vim.cmd "command! AdaptSystem lua require('CONFIG.util').adapt_system()"
