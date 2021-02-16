local map_s = function(mode, left, right)
	vim.api.nvim_set_keymap(mode, left, right, { noremap = true, silent = true })
end

local map = function(mode, left, right)
	vim.api.nvim_set_keymap(mode, left, right, { noremap = true })
end

local map_xs = function(mode, left, right)
	vim.api.nvim_set_keymap(mode, left, right, { noremap = true, silent = true, expr = true})
end

vim.g.mapleader = " "

-- Easy normal mode
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })

-- Easy write
vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr>", { noremap = true, silent = true })

-- Easy quit
vim.api.nvim_set_keymap("n", "<C-q>", ":q<cr>", { noremap = true, silent = true })

-- Reload neovim
vim.api.nvim_set_keymap('n', '<leader>,', ':luafile ~/.config/nvim/init.lua<cr>', { noremap = true, silent = true })

-- Better split navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Delete using the black hole register
vim.api.nvim_set_keymap('n', 'x', '"_d', { noremap = true, silent = true })

--Remove THE ANNOYING command line window and ex mode
vim.api.nvim_set_keymap('n', 'q:', ':echo "CRISIS AVERTED"<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Q', ':echo "CRISIS AVERTED"<cr>',  { noremap = true, silent = true })

-- Use Tab in popup menus
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"',     { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, noremap = true, silent = true })

-- Toggle Rnvimr
vim.api.nvim_set_keymap('n', '<leader>e', ":RnvimrToggle<cr>", { noremap = true, silent = true })

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', ':lua require("telescope.builtin").find_files()<cr>',            { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<cr>',             { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':lua require("telescope.builtin").buffers()<cr>',               { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':lua require("telescope.builtin").lsp_document_symbols()<cr>',  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fS', ':lua require("telescope.builtin").lsp_workspace_symbols()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fa', ':lua require("telescope.builtin").lsp_code_actions()<cr>',      { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fm', ':lua require("telescope.builtin").keymaps()<cr>',               { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', ':lua require("telescope.builtin").treesitter()<cr>',            { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', ':lua require("telescope.builtin").highlights()<cr>',            { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fp', ':lua require("telescope").extensions.packer.plugins()<cr>',     { noremap = true, silent = true })

-- LSP
vim.api.nvim_set_keymap('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>',                   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<cr>',                  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>li', ':lua vim.lsp.buf.implementation()<cr>',               { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<cr>',               { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lk', ':lua vim.lsp.buf.hover()<cr>',                        { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lr', ':lua vim.lsp.buf.rename()<cr>',                       { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lR', ':lua vim.lsp.buf.references()<cr>',                   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>le', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lH', ':lua require("lsp_extensions").inlay_hints()<cr>',    { noremap = true, silent = true })

-- Vim Rooter
vim.api.nvim_set_keymap('n', '<leader>.', ':Rooter<cr>', { noremap = true, silent = true })

-- Kommentary
vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default",  { silent = true })
vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", { silent = true })
vim.api.nvim_set_keymap("v", "<leader>c", "<Plug>kommentary_visual_default", { silent = true })

-- Glow
vim.api.nvim_set_keymap("n", "<leader>p", ":Glow<cr>", { noremap = true, silent = true })

-- Git
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ga", ":Git add ",       { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<cr>",   { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gP", ":Git pull<cr>",   { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gb", ":Git blame<cr>",  { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gl", ":Git log<cr>",    { noremap = true })
