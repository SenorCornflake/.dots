local lspconfig = require "lspconfig"

local servers = {
	sumneko_lua = {
		cmd = { "lua-language-server", "-E" },
		settings = {
			Lua = {
				workspace = {
					library = {
						["/usr/share/nvim/runtime/lua"] = true,
						["/usr/share/nvim/runtime/lua/lsp"] = true,
						["/usr/share/awesome/lib"] = true
					}
				},
				diagnostics = {
					enable = false,
					globals = {
						-- Neovim
						"vim",

						-- AwesomeWM
						"awesome",
						"client",
						"root"
					},
				},
			}
		},
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},
	rust_analyzer = {
		root_dir = lspconfig.util.root_pattern(".root", ".git", "Cargo.toml")
	},

	intelephense = {
		root_dir = lspconfig.util.root_pattern(".root", ".git"),
		settings = {
			intelephense = {
				format = {
					enable = true
				},
				diagnostics = {
					run = "onType"
				},
				maxMemory = 200
			}
		}
	},

	tsserver = {
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},

	cssls = {
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},

	html = {
		root_dir = lspconfig.util.root_pattern(".root", ".git"),
		filetypes = {"php", "html"}
	},

	pyright = {
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},

	jsonls = {
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},

}

for server, config in pairs(servers) do
	config.on_attach = config.on_attach or function()
		print("Started " .. server)
	end

	lspconfig[server].setup(config)
end


vim.cmd "autocmd ColorScheme * highlight clear LspDiagnosticsDefaultError"
vim.cmd "autocmd ColorScheme * highlight clear LspDiagnosticsDefaultWarning"
vim.cmd "autocmd ColorScheme * highlight clear LspDiagnosticsDefaultInformation"
vim.cmd "autocmd ColorScheme * highlight clear LspDiagnosticsDefaultHint"
vim.cmd "autocmd ColorScheme * highlight link LspDiagnosticsDefaultError ErrorMsg"
vim.cmd "autocmd ColorScheme * highlight link LspDiagnosticsDefaultWarning Tag"
vim.cmd "autocmd ColorScheme * highlight link LspDiagnosticsDefaultInformation Function"
vim.cmd "autocmd ColorScheme * highlight link LspDiagnosticsDefaultHint Special"

-- Redefine the signs here to that if I refresh neovim then it won't complain about the signs not existing
vim.cmd "sign define LspDiagnosticsSignError text=E texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError"
vim.cmd "sign define LspDiagnosticsSignWarning text=W texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning"
vim.cmd "sign define LspDiagnosticsSignInformation text=I texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation"
vim.cmd "sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint"

-- vim.cmd "sign undefine LspDiagnosticsSignError"
-- vim.cmd "sign undefine LspDiagnosticsSignWarning"
-- vim.cmd "sign undefine LspDiagnosticsSignInformation"
-- vim.cmd "sign undefine LspDiagnosticsSignHint"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			spacing = 4,
			prefix = "* "
		}
	}
)

--vim.cmd "autocmd CursorHold * Lspsaga show_line_diagnostics"
