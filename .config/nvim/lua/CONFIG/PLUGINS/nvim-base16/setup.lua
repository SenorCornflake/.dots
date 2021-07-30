local setup = function()
	-- nvim-base16 is an "unofficial" theme, it does not do the proper autocommands
	-- before or after changing colors, which my config heavily relies on, so we apply them here
	vim.cmd "doautocmd ColorSchemePre"

	vim.g.colors_name = "base16"

	require "base16-colorscheme".setup {
		-- theme section is managed by exconman
		-- <theme>
		base00 = "#1a1b26",
		base01 = "#292e42",
		base02 = "#33467c",
		base03 = "#565f89",
		base04 = "#a9b1d6",
		base05 = "#c0caf5",
		base06 = "#c0caf5",
		base07 = "#c0caf5",
		base08 = "#9ece6a",
		base09 = "#ff9e64",
		base0A = "#2ac3de",
		base0B = "#9ece6a",
		base0C = "#2ac3de",
		base0D = "#7aa2f7",
		base0E = "#bb9af7",
		base0F = "#ff9e64"
		-- </theme>
	}
	
	vim.cmd "doautocmd ColorScheme"
end
setup()
