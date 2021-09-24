vim.api.nvim_exec([[
	call wilder#setup({'modes': [':', '/', '?']})

	call wilder#set_option('pipeline', [
		  \   wilder#branch(
		  \     wilder#cmdline_pipeline({
		  \       'fuzzy': 1,
		  \       'set_pcre2_pattern': has('nvim'),
		  \     }),
		  \     wilder#python_search_pipeline({
		  \       'pattern': 'fuzzy',
		  \     }),
		  \   ),
		  \ ])

	call wilder#set_option('renderer', wilder#popupmenu_renderer({
		  \   'highlighter': [
		  \     wilder#pcre2_highlighter(),
		  \     wilder#basic_highlighter(),
		  \   ],
		  \   'left': [
		  \     ' ', wilder#popupmenu_devicons(),
		  \   ],
		  \   'right': [
		  \     ' ', wilder#popupmenu_scrollbar(),
		  \   ],
		  \ }))
]], false)
