local map_silent = function(mode, left, right)
	vim.api.nvim_set_keymap(mode, left, right, { noremap = true, silent = true })
end

local map_loud = function(mode, left, right)
	vim.api.nvim_set_keymap(mode, left, right, { noremap = true })
end

vim.g.mapleader = " "


-- Easy normal mode
map_silent("i", "kj", "<Esc>")

-- Easy write
map_loud("n", "<leader>w", ":w<cr>")

-- Easy quit
map_loud("n", "<C-q>", ":q<cr>")

-- Easier file completion
map_silent("i", "<C-f>", "<C-x><C-f>")

-- Reload neovim
map_silent('n', '<leader>,', ':luafile ~/.config/nvim/init.lua<cr>')

-- Better split navigation
map_silent('n', '<C-h>', '<C-w>h')
map_silent('n', '<C-j>', '<C-w>j')
map_silent('n', '<C-k>', '<C-w>k')
map_silent('n', '<C-l>', '<C-w>l')

--Remove THE $%^#@#* ANNOYING command line window and ex mode
map_silent('n', 'q:', ':echo "CRISIS AVERTED"<cr>')
map_silent('n', 'Q', ':echo "CRISIS AVERTED"<cr>')

-- Use Tab in completion menus
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, silent = true, expr = true })

-- Toggle Rnvimr
map_silent('n', '<leader>e', ":RnvimrToggle<cr>")


-- Telescope
map_silent('n', '<leader>ff', ':lua require("telescope.builtin").find_files()<cr>')
map_silent('n', '<leader>fg', ':lua require("telescope.builtin").live_grep()<cr>')
map_silent('n', '<leader>fb', ':lua require("telescope.builtin").buffers()<cr>')
map_silent('n', '<leader>fs', ':lua require("telescope.builtin").lsp_document_symbols()<cr>')
map_silent('n', '<leader>fS', ':lua require("telescope.builtin").lsp_workspace_symbols()<cr>')
map_silent('n', '<leader>fa', ':lua require("telescope.builtin").lsp_code_actions()<cr>')
map_silent('n', '<leader>fm', ':lua require("telescope.builtin").keymaps()<cr>')
map_silent('n', '<leader>ft', ':lua require("telescope.builtin").treesitter()<cr>')
map_silent('n', '<leader>fh', ':lua require("telescope.builtin").highlights()<cr>')
map_silent('n', '<leader>fp', ':lua require("telescope").extensions.packer.plugins()<cr>')

-- LSP
map_silent('n', '<leader>ld', ':lua vim.lsp.buf.definition()<cr>')
map_silent('n', '<leader>lD', ':lua vim.lsp.buf.declaration()<cr>')
map_silent('n', '<leader>li', ':lua vim.lsp.buf.implementation()<cr>')
map_silent('n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<cr>')
map_silent('n', '<leader>lk', ':lua vim.lsp.buf.hover()<cr>')
map_silent('n', '<leader>lr', ':lua vim.lsp.buf.references()<cr>')
map_silent('n', '<leader>le', ':lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
map_loud('n', '<leader>lH', ':lua require("lsp_extensions").inlay_hints()<cr>')


-- Vim Rooter
map_loud('n', '<leader>.', ':Rooter<cr>')
