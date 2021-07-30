# Files
* `init.lua` - Entry point
* `lua/CONFIG/bindings.lua` - Contains all keybindings and commands not strictly related to a plugin (Autoloads all plugin `bindings.lua` files)
* `lua/CONFIG/colorscheme.lua` - Colorscheme related things, not much in here
* `lua/CONFIG/lsp.lua` - All lsp related stuff
* `lua/CONFIG/opts.lua` - Vim settings, and possibly some generic autocmds
* `lua/CONFIG/plugins.lua` - The file that manages plugins with a plugin manager (Autoloads all plugin `setup.lua` files)
* `lua/CONFIG/statusline.lua` - The file that builds the statusline. Although it uses galaxyline, which is a plugin, I decided to put it here because building a statusline itself in essence is not restricted to a plugin.
* `lua/CONFIG/util.lua` - Contains a few functions that are used throughout the config
* `lua/CONFIG/PLUGINS/*/setup.lua` - Contains setting specific to the plugin
* `lua/CONFIG/PLUGINS/*/bindings.lua` - Bindings or commands specific to the plugin

## Possible Improvements
1. Galaxyline highlights never worked for me for some reason, so I hacked it by setting the highlights myself and applying them everytime the mode changes,
which is not optimal. Figure out the correct way to do it with ability to switch colors when colorscheme changes.
2. Lazy loading, it'll be a pain, especially since I made this config oblivious to the fact that it exists.
Initial startup when rebooting system is slow, but after that it's alright, so it's not necessary (I think).


