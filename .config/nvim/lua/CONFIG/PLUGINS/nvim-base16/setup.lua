-- TODO: Set this up properly
local setup = function()
	require "base16-colorscheme".setup {
		-- <theme>
	base00 = "#1b202a",
	base01 = "#232936",
	base02 = "#323c4d",
	base03 = "#51617d",
	base04 = "#9aa7bd",
	base05 = "#9aa7bd",
	base06 = "#9aa7bd",
	base07 = "#9aa7bd",
	base08 = "#709d6c",
	base09 = "#b15e7c",
	base0A = "#b3785d",
	base0B = "#709d6c",
	base0C = "#56adb7",
	base0D = "#b5a262",
	base0E = "#608cc3",
	base0F = "#b15e7c"
		-- </theme>
	}
	
	vim.cmd "doautocmd ColorScheme"
end
setup()
