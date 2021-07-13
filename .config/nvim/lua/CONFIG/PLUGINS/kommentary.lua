vim.g.kommentary_create_default_mappings = false

local cl = require "kommentary.config".configure_language

cl("default", {
	use_consistent_indentation = true,
	ignore_whitespace = true,
})

cl("lua", {
	prefer_single_line_comments = true
})
