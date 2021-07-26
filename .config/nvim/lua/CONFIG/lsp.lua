local lspconfig = require "lspconfig"
local util = require "CONFIG.util"

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
		cmd = { "css-languageserver", "--stdio" },
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},

	html = {
		cmd = { "vscode-html-languageserver", "--stdio" },
		root_dir = lspconfig.util.root_pattern(".root", ".git"),
		filetypes = {"php", "html"}
	},

	pyright = {
		root_dir = lspconfig.util.root_pattern(".root", ".git")
	},

	jsonls = {
		cmd = { "vscode-json-languageserver", "--stdio" },
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

local bg = util.get_color(
	{
		{ "SignColumn", "bg" },
		{ "Normal", "bg" }
	},
	{
		cterm = "0",
		gui = "#000000"
	}
)
local error = util.get_color(
	{
		{ "ErrorMsg", "fg" }
	},
	{
		cterm = "0",
		gui = "#000000"
	}
)
local warn = util.get_color(
	{
		{ "Constant", "fg" },
		{ "WarningMsg", "fg"  },
		{ "Boolean", "fg" },
		{ "Delimiter", "fg" }
	},
	{
		cterm = "0",
		gui = "#000000"
	}
)
local hint = util.get_color(
	{
		{ "Special", "fg" },
		{ "Function", "fg" },
		{ "Include", "fg" }
	},
	{
		cterm = "0",
		gui = "#000000"
	}
)
local info = util.get_color(
	{
		{ "String", "fg" },
		{ "DiffAdded", "fg" },
		{ "DiffAdd", "fg" },
	},
	{
		cterm = "0",
		gui = "#000000"
	}
)

vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultError guifg=" .. error.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. error.cterm .. " ctermbg=" .. bg.cterm)
vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultWarning guifg=" .. warn.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. warn.cterm .. " ctermbg=" .. bg.cterm)
vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultInformation guifg=" .. info.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. info.cterm .. " ctermbg=" .. bg.cterm)
vim.cmd("autocmd ColorScheme * highlight LspDiagnosticsDefaultHint guifg=" .. hint.gui .. " guibg=" .. bg.gui .. " ctermfg=" .. hint.cterm .. " ctermbg=" .. bg.cterm)

vim.cmd "sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsDefaultError linehl= numhl=LspDiagnosticsDefaultError"
vim.cmd "sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsDefaultWarning linehl= numhl=LspDiagnosticsDefaultWarning"
vim.cmd "sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsDefaultInformation linehl= numhl=LspDiagnosticsDefaultInformation"
vim.cmd "sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsDefaultHint linehl= numhl=LspDiagnosticsDefaultHint"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			spacing = 4,
			prefix = "» "
		}
	}
)

--vim.cmd "autocmd CursorHold * Lspsaga show_line_diagnostics"
