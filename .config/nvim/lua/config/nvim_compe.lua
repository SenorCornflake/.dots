--vim.g.completion_matching_strategy_list = {
--	"exact",
--	"substring",
--	"fuzzy",
--	"all"
--}
--
--vim.g.completion_matching_smart_case = true

require "compe".setup {
	enabled = true,
  	debug = false,
	min_length = 1,
	preselect = 'disabled',
	throttle_time = 1,
	source_timeout = 1,
	incomplete_delay = 1,
	allow_prefix_unmatch = false,
	source = {
		path = true,
		buffer = true,
		calc = true,
		vsnip = true,
		nvim_lsp = true,
		spell = true,
		--tags = true,
		--snippets_nvim = true,
		--treesitter = true,
	}
}

