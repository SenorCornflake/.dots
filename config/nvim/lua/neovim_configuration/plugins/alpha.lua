 local alpha = require'alpha'
 local dashboard = require'alpha.themes.dashboard'
 dashboard.section.header.val = {
	[[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
	[[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
	[[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
	[[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
	[[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
	[[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
	[[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
	[[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
	[[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
	[[                                ░                  ]]
 }
 dashboard.section.buttons.val = {
	 dashboard.button( "e", "  New file" , ":ene <BAR> startinsert <CR>"),
	 dashboard.button( "q", "  Quit NVIM" , ":qa<CR>"),
 }
 dashboard.section.footer.val = ""

 dashboard.config.opts.noautocmd = true

 vim.cmd[[autocmd User AlphaReady echo 'ready']]

 alpha.setup(dashboard.config)
