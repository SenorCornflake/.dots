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
		nvim_lsp = true,
		treesitter = true,

		spell = false,
		tags = false,
		snippets_nvim = false,
		calc = false,
		vsnip = false,
	}
}
