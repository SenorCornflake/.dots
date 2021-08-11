# Files
* `init.lua` - Entry point
* `lua/CONFIG/bindings.lua` - Contains all keybindings and commands not strictly related to a plugin
* `lua/CONFIG/colorscheme.lua` - Colorscheme related things, not much in here
* `lua/CONFIG/lsp.lua` - All lsp related stuff
* `lua/CONFIG/opts.lua` - Vim settings, and possibly some generic autocmds
* `lua/CONFIG/plugins.lua` - The file that manages plugins with a plugin manager
* `lua/CONFIG/statusline.lua` - The file that builds the statusline. Although it uses galaxyline, which is a plugin, I decided to put it here because building a statusline itself in essence is not restricted to a plugin.
* `lua/CONFIG/util.lua` - Contains a few functions that are used throughout the config
* `lua/CONFIG/PLUGINS/*/setup.lua` - Contains setting specific to the plugin
* `lua/CONFIG/PLUGINS/*/bindings.lua` - Bindings or commands specific to the plugin
