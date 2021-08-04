local util = require "CONFIG.util"
util.bind("n", "<leader>f.", ":lua require 'telescope.builtin'.builtin()<CR>")
util.bind("n", "<leader>ff", ":lua require 'telescope.builtin'.find_files()<CR>")
util.bind("n", "<leader>fF", ":lua require 'telescope.builtin'.file_browser()<CR>")
util.bind("n", "<leader>fg", ":lua require 'telescope.builtin'.live_grep()<CR>")
util.bind("n", "<leader>fb", ":lua require 'telescope.builtin'.buffers()<CR>")
util.bind("n", "<leader>fs", ":lua require 'telescope.builtin'.lsp_document_symbols()<CR>")
util.bind("n", "<leader>fr", ":lua require 'telescope.builtin'.lsp_references()<CR>")
util.bind("n", "<leader>fS", ":lua require 'telescope.builtin'.lsp_workspace_symbols()<CR>")
util.bind("n", "<leader>fe", ":lua require 'telescope.builtin'.lsp_document_diagnostics()<CR>")
util.bind("n", "<leader>fE", ":lua require 'telescope.builtin'.lsp_workspace_diagnostics()<CR>")
util.bind("n", "<leader>f/", ":lua require 'telescope.builtin'.current_buffer_fuzzy_find()<CR>")