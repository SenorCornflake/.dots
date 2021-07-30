local util = require "CONFIG.util"
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

-- Copy to end of line without newline
util.bind("n", "Y", "y$")

-- Better indenting experience
util.bind("v", ">", ">gv")
util.bind("v", "<", "<gv")

-- Better writing
util.bind("n", "<leader>w", ":w<CR>")

-- Use tab in popup menus
util.bind('i', '<Tab>'  , 'pumvisible() ? "<C-n>" : "<Tab>"'  , { expr = true, noremap = true, silent = true })
util.bind('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true, noremap = true, silent = true })

-- Reload neovim
util.bind("n", "<leader>,", ":luafile ~/.config/nvim/init.lua<CR>")

-- Undo breakpoints
util.bind("i", ",", ",<c-g>u")
util.bind("i", ".", ".<c-g>u")
util.bind("i", ";", ";<c-g>u")
util.bind("i", "!", "!<c-g>u")
util.bind("i", "?", "?<c-g>u")

-- Keep searches centered
util.bind("n", "n", "nzzzv")
util.bind("n", "N", "Nzzzv")

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

----------------------------
-- Color Scheme Switching --
----------------------------
util.bind("n", "<Left>", ":lua require('CONFIG.util').next_colorscheme(true)<CR>")
util.bind("n", "<Right>", ":lua require('CONFIG.util').next_colorscheme(false)<CR>")

----------------------------------
-- Display highlight group name --
----------------------------------
vim.cmd "command! GetHighlight call SynStack()"

----------------------------------------------
-- Generate base16 theme from active scheme --
----------------------------------------------
vim.cmd "command! Base16ify lua print(require('CONFIG.util').base16ify())"

-----------------------------------
-- Adapt system to current theme --
-----------------------------------
vim.cmd "command! AdaptSystem lua require('CONFIG.util').adapt_system()"

----------------
-- Sudo Write --
----------------
vim.cmd "command! SudoWrite w !sudo tee %"

-- Load all plugin bindings
 local plugin_configs = util.scandir("~/.config/nvim/lua/CONFIG/PLUGINS")

 for i, config in pairs(plugin_configs) do
 	local plugins_dir = util.expanduser("~/.config/nvim/lua/CONFIG/PLUGINS/")
 	local filename = config:gsub(".lua", "")

 	if util.isdir(plugins_dir .. config) then
 		if util.file_exists(plugins_dir .. config .. "/bindings.lua") then
 			require("CONFIG.PLUGINS." .. filename .. ".bindings")
 		end
 	end
 end
