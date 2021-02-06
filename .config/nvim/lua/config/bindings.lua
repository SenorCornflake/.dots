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
map_s("i", "kj", "<Esc>")

-- Easy write
map("n", "<leader>w", ":w<cr>")

-- Easy quit
map("n", "<C-q>", ":q<cr>")


-- Easier file completion
map_s("i", "<C-f>", "<C-x><C-f>")

-- Reload neovim
map_s('n', '<leader>,', ':luafile ~/.config/nvim/init.lua<cr>')

-- Better split navigation
map_s('n', '<C-h>', '<C-w>h')
map_s('n', '<C-j>', '<C-w>j')
map_s('n', '<C-k>', '<C-w>k')
map_s('n', '<C-l>', '<C-w>l')

-- Delete using the black hole register
map_s('n', 'x', '"_d')

--Remove THE ANNOYING command line window and ex mode
map('n', 'q:', ':echo "CRISIS AVERTED"<cr>')
map('n', 'Q', ':echo "CRISIS AVERTED"<cr>')

-- Use Tab in popup menus
map_xs('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"')
map_xs('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"')

-- Toggle Rnvimr
map_s('n', '<leader>e', ":RnvimrToggle<cr>")


-- Telescope
map('n', '<leader>ff', ':lua require("telescope.builtin").find_files()<cr>')
map('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<cr>')
map('n', '<leader>fb', ':lua require("telescope.builtin").buffers()<cr>')
map('n', '<leader>fs', ':lua require("telescope.builtin").lsp_document_symbols()<cr>')
map('n', '<leader>fS', ':lua require("telescope.builtin").lsp_workspace_symbols()<cr>')
map('n', '<leader>fa', ':lua require("telescope.builtin").lsp_code_actions()<cr>')
map('n', '<leader>fm', ':lua require("telescope.builtin").keymaps()<cr>')
map('n', '<leader>ft', ':lua require("telescope.builtin").treesitter()<cr>')
map('n', '<leader>fh', ':lua require("telescope.builtin").highlights()<cr>')
map('n', '<leader>fp', ':lua require("telescope").extensions.packer.plugins()<cr>')

-- LSP
map('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>')
map('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<cr>')
map('n', '<leader>li', ':lua vim.lsp.buf.implementation()<cr>')
map('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<cr>')
map('n', '<leader>lk', ':lua vim.lsp.buf.hover()<cr>')
map('n', '<leader>lr', ':lua vim.lsp.buf.rename()<cr>')
map('n', '<leader>lR', ':lua vim.lsp.buf.references()<cr>')
map('n', '<leader>le', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
map('n', '<leader>lH', ':lua require("lsp_extensions").inlay_hints()<cr>')


-- Vim Rooter
map('n', '<leader>.', ':Rooter<cr>')
