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
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	tsserver = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	cssls = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	html = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	pyright = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

	jsonls = {
		root_dir = lspconfig.util.root_pattern('.root', '.git')
	},

}

for server, config in pairs(servers) do
	config.on_attach = function()
		print('started ' .. server)
	end

	lspconfig[server].setup(config)
end

-- set highlights
local h = {
	"LspDiagnosticsDefaultError",
	"LspDiagnosticsDefaultWarning",
	"LspDiagnosticsDefaultInformation",
	"LspDiagnosticsDefaultHint",
	--"LspDiagnosticsVirtualTextError",
	--"LspDiagnosticsVirtualTextWarning",
	--"LspDiagnosticsVirtualTextInformation",
	--"LspDiagnosticsVirtualTextHint",
	--"LspDiagnosticsUnderlineError",
	--"LspDiagnosticsUnderlineWarning",
	--"LspDiagnosticsUnderlineInformation",
	--"LspDiagnosticsUnderlineHint",
	--"LspDiagnosticsFloatingError",
	--"LspDiagnosticsFloatingWarning",
	--"LspDiagnosticsFloatingInformation",
	--"LspDiagnosticsFloatingHint",
	--"LspDiagnosticsSignError",
	--"LspDiagnosticsSignWarning",
	--"LspDiagnosticsSignInformation",
	--"LspDiagnosticsSignHint",
}

vim.cmd ":highlight clear LspDiagnosticsDefaultError"
vim.cmd ":highlight clear LspDiagnosticsDefaultWarning"
vim.cmd ":highlight clear LspDiagnosticsDefaultInformation"
vim.cmd ":highlight clear LspDiagnosticsDefaultHint"
vim.cmd ":highlight link LspDiagnosticsDefaultError ErrorMsg"
vim.cmd ":highlight link LspDiagnosticsDefaultWarning Tag"
vim.cmd ":highlight link LspDiagnosticsDefaultInformation Function"
vim.cmd ":highlight link LspDiagnosticsDefaultHint Special"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = {
			spacing = 4,
			prefix = " ! "
		}
	}
)

-- Rust Inlay hints
vim.cmd('autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require("lsp_extensions").inlay_hints{ prefix = " -- ", highlight = "Special", aligned = true, enabled = {"ChainingHint"} }')

-- Show diagnostics on hover
vim.cmd 'autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()'

-- Completion
vim.cmd "autocmd BufEnter * lua require'completion'.on_attach()"

vim.cmd("")
