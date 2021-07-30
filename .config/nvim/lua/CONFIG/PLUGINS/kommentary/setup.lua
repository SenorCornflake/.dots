vim.g.kommentary_create_default_mappings = false

local cl = require "kommentary.config".configure_language

cl("default", {
	use_consistent_indentation = true,
	ignore_whitespace = true,
	single_line_comment_string = 'auto',
	multi_line_comment_strings = 'auto'
})

cl("lua", {
	prefer_single_line_comments = true
})
