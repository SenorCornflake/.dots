require 'nvim-treesitter.configs'.setup {
-- ensure_installed = {
-- 	"c_sharp",
-- 	"svelte",
-- 	"c",
-- 	"teal",
-- 	"java",
-- 	"python",
-- 	"sparql",
-- 	"comment",
-- 	"dart",
-- 	"lua",
-- 	"ocaml",
-- 	"go",
-- 	"haskell",
-- 	"yaml",
-- 	"json",
-- 	"jsdoc",
-- 	"ledger",
-- 	"php",
-- 	"julia",
-- 	"supercollider",
-- 	"turtle",
-- 	"r",
-- 	"html",
-- 	"typescript",
-- 	"devicetree",
-- 	"gdscript",
-- 	"jsonc",
-- 	"rst",
-- 	"regex",
-- 	"swift",
-- 	"verilog",
-- 	"ql",
-- 	"fennel",
-- 	"query",
-- 	"nix",
-- 	"cpp",
-- 	"elm",
-- 	"kotlin",
-- 	"ruby",
-- 	"vue",
-- 	"ocamllex",
-- 	"scala",
-- 	"toml",
-- 	"rust",
-- 	"bash",
-- 	"graphql",
-- 	"javascript",
-- 	"css",
-- 	"glimmer",
-- 	"erlang",
-- 	"clojure",
-- 	"ocaml_interface"
-- },
	ensure_installed = "all",
	highlight = {
		enable = true,
		-- Keeps old indenting
		additional_vim_regex_highlighting = true
	},
	indent = {
		enable = false
	}
}
