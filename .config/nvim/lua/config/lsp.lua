local lspconfig = require('lspconfig')

local servers = {
	sumneko_lua = {
		cmd = { "lua-language-server", "-E" },
		settings = {
			Lua = {
				workspace = {
					library = {
						['/usr/share/nvim/runtime/lua'] = true,
						['/usr/share/nvim/runtime/lua/lsp'] = true,
						['/usr/share/awesome/lib'] = true
					}
				},
				diagnostics = {
					enable = true,
					globals = {
						-- VIM
						"vim",
						"use", -- Packer use keyword

						-- AwesomeWM
						"awesome",
						"client",
						"root"
					},
				},
			}
		},
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},
	rust_analyzer = {
		root_dir = lspconfig.util.root_pattern('.root', '.git', 'Cargo.toml')
	},

	intelephense = {
		root_dir = lspconfig.util.root_pattern('.root', '.git'),
		settings = {
			intelephense = {
				format = {
					enable = false
				},
				diagnostics = {
					run = "onType"
				},
				maxMemory = 200
			}
		}
	},

	tsserver = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	cssls = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	html = {
		root_dir = lspconfig.util.root_pattern('.root', '.git'),
		filetypes = {"php", "html"}
	},

	pyright = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	jsonls = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

}

for server, config in pairs(servers) do
	config.on_attach = config.on_attach or function()
		print('started ' .. server)
	end

	lspconfig[server].setup(config)
end

vim.cmd ":highlight clear LspDiagnosticsDefaultError"
vim.cmd ":highlight clear LspDiagnosticsDefaultWarning"
vim.cmd ":highlight clear LspDiagnosticsDefaultInformation"
vim.cmd ":highlight clear LspDiagnosticsDefaultHint"
vim.cmd ":highlight link LspDiagnosticsDefaultError ErrorMsg"
vim.cmd ":highlight link LspDiagnosticsDefaultWarning Tag"
vim.cmd ":highlight link LspDiagnosticsDefaultInformation Function"
vim.cmd ":highlight link LspDiagnosticsDefaultHint Special"

vim.cmd "sign define LspDiagnosticsSignError text=E texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError"
vim.cmd "sign define LspDiagnosticsSignWarning text=W texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning"
vim.cmd "sign define LspDiagnosticsSignInformation text=I texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation"
vim.cmd "sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			spacing = 4,
			prefix = "! "
		}
	}
)

-- Rust Inlay hints
vim.cmd('autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require("lsp_extensions").inlay_hints{ prefix = " -- ", highlight = "Special", aligned = true, enabled = {"ChainingHint"} }')

-- Show diagnostics on hover
--vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'

-- Completion
--vim.cmd "autocmd BufEnter * lua require'completion'.on_attach()"


