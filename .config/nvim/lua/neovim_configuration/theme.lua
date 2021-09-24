local util = require "neovim_configuration.util"
local cmd = vim.cmd

local colorscheme = "material"

local config_dir = os.getenv("XDG_CONFIG_HOME")
local has_theme = util.file_exists(config_dir .. "/nvim/lua/neovim_configuration/themes/" .. colorscheme .. ".lua")

-- Each theme gets it's unique custom hook so that we can selectively choose which theme we want to load
LOAD_THEME = function()
	if not has_theme then
		cmd ("doautocmd User load_" .. colorscheme .. "_theme")
		cmd ("colorscheme " .. colorscheme)
	else
		if colorscheme == "default" then
			cmd "colorscheme default"
			return
		end

		cmd ("doautocmd User load_" .. colorscheme .. "_theme")
		require ("neovim_configuration.themes." .. colorscheme)
	end

	cmd "doautocmd User ThemeLoaded"
end

cmd "autocmd VimEnter * lua LOAD_THEME()"
