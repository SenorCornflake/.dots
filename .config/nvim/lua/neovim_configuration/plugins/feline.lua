local util = require "neovim_configuration.util"
local cmd = vim.cmd
local lsp = require('feline.providers.lsp')

-- We have one problem, if you edit a file directly (nvim file.txt), then it won't detect the gitsigns highlight groups. It's a small issue, but worth mentioning

SetupStatusline = function()
	local components = {
		active = {
			{},
			{},
			{},
		},
		inactive = {
			{},
			{},
			{},
		},
	}

	local al = function(item)
		table.insert(components.active[1], item)
	end
	local am = function(item)
		table.insert(components.active[2], item)
	end
	local ar = function(item)
		table.insert(components.active[3], item)
	end
	local il = function(item)
		table.insert(components.inactive[1], item)
	end
	local im = function(item)
		table.insert(components.inactive[2], item)
	end
	local ir = function(item)
		table.insert(components.inactive[3], item)
	end

	local colors = {
		bg = util.get_color(
			{
				{ "StatusLine", "bg" },
				{ "Normal", "bg" },
			}
		),
		fg = util.get_color(
			{
				{ "StatusLine", "fg" },
				{ "Normal", "fg" },
			}
		),
		insert = util.get_color(
			{
				{ "Function", "fg" }
			}
		),
		normal = util.get_color(
			{
				{ "String", "fg" }
			}
		),
		visual = util.get_color(
			{
				{ "Conditional", "fg" }
			}
		),
		other = util.get_color(
			{
				{ "Tag", "fg" },
				{ "Search", "fg" },
			}
		),
		filename = util.get_color(
			{
				{ "Include", "fg" },
			}
		),
		error = util.get_color(
			{
				{ "LspDiagnosticsDefaultError", "fg" },
			}
		),
		warn = util.get_color(
			{
				{ "LspDiagnosticsDefaultWarning", "fg" },
			}
		),
		info = util.get_color(
			{
				{ "LspDiagnosticsDefaultInformation", "fg" },
			}
		),
		hint = util.get_color(
			{
				{ "LspDiagnosticsDefaultHint", "fg" },
			}
		),
		other_fg = util.get_color(
			{
				{ "String", "fg" },
			}
		),

		lsp_clients = util.get_color(
			{
				{ "Special", "fg" },
			}
		),

		git_branch = util.get_color(
			{
				{ "Tag", "fg" },
				{ "Search", "fg" },
			}
		),
		git_diff_added = util.get_color(
			{
				{ "GitSignsAdd", "fg" },
				{ "DiffAdd", "fg" },
				{ "DiffAdded", "fg" },
				{ "MoreMsg", "fg" },
			},
			{
				cterm = "0",
				gui = "#00aa00"
			}
		),
		git_diff_changed = util.get_color(
			{
				{ "GitSignsChange", "fg" },
				{ "DiffChange", "fg" },
				{ "DiffChanged", "fg" },
				{ "Include", "fg" },
				{ "Function", "fg" },
				{ "Conditional", "fg" },
				{ "Keyword", "fg" },
			},
			{
				cterm = "0",
				gui = "#00aaaa"
			}
		),
		git_diff_removed = util.get_color(
			{
				{ "GitSignsDelete", "fg" },
				{ "DiffDelete", "fg" },
				{ "DiffRemoved", "fg" },
				{ "ErrorMsg", "fg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),

	}

	cmd ("hi! StatuslineBackground ctermfg="      .. colors.fg.cterm        .. " guifg=" .. colors.fg.gui        .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineFileName ctermfg="      .. colors.filename.cterm        .. " guifg=" .. colors.filename.gui        .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)

	cmd ("hi! StatuslineLSPError ctermfg="      .. colors.error.cterm           .. " guifg=" .. colors.error.gui           .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineLSPWarn ctermfg="       .. colors.warn.cterm            .. " guifg=" .. colors.warn.gui            .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineLSPInfo ctermfg="       .. colors.info.cterm            .. " guifg=" .. colors.info.gui            .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineLSPHint ctermfg="       .. colors.hint.cterm            .. " guifg=" .. colors.hint.gui            .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineLSPClients ctermfg="    .. colors.lsp_clients.cterm     .. " guifg=" .. colors.lsp_clients.gui     .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)

	cmd ("hi! StatuslineGitBranch ctermfg="    .. colors.git_branch.cterm     .. " guifg=" .. colors.git_branch.gui     .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineGitDiffAdded ctermfg="    .. colors.git_diff_added.cterm     .. " guifg=" .. colors.git_diff_added.gui     .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineGitDiffChanged ctermfg="    .. colors.git_diff_changed.cterm     .. " guifg=" .. colors.git_diff_changed.gui     .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineGitDiffRemoved ctermfg="    .. colors.git_diff_removed.cterm     .. " guifg=" .. colors.git_diff_removed.gui     .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)

	cmd ("hi! StatuslineEncoding ctermfg="      .. colors.other_fg.cterm        .. " guifg=" .. colors.other_fg.gui        .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineFileFormat ctermfg="    .. colors.other_fg.cterm        .. " guifg=" .. colors.other_fg.gui        .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
	cmd ("hi! StatuslineFileType ctermfg="    .. colors.other_fg.cterm        .. " guifg=" .. colors.other_fg.gui        .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)

	local mode_colors = {
		['n']  = colors.normal,
		['no'] = colors.normal,

		['v']  = colors.visual, 
		['V']  = colors.visual, 
		[''] = colors.visual, 
		['s']  = colors.visual, 
		['S']  = colors.visual, 
		[''] = colors.visual, 

		['i']  = colors.insert, 
		['ic'] = colors.insert, 
		['ix'] = colors.insert, 

		['R']  = colors.other,  
		['Rv'] = colors.other,  
		['c']  = colors.other,  
		['cv'] = colors.other,  
		['ce'] = colors.other,  
		['r']  = colors.other,  
		['rm'] = colors.other,  
		['r?'] = colors.other,  
		['!']  = colors.other,  
		['t']  = colors.other,  
	}

	local mode_labels = {
		['n']  = 'NORMAL',
		['no'] = 'N·Operator Pending',
		['v']  = 'VISUAL',
		['V']  = 'V·Line',
		[''] = 'V·Block',
		['s']  = 'Select',
		['S']  = 'S·Line',
		[''] = 'S·Block',
		['i']  = 'INSERT',
		['ic'] = 'INSERT',
		['ix'] = 'INSERT',
		['R']  = 'Replace',
		['Rv'] = 'V·Replace',
		['c']  = 'COMMAND',
		['cv'] = 'Vim Ex',
		['ce'] = 'Ex',
		['r']  = 'Prompt',
		['rm'] = 'More',
		['r?'] = 'Confirm',
		['!']  = 'Shell',
		['t']  = 'TERMINAL'
	}

	local buffer_not_empty = function()
		if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
			return true
		end
		return false
	end

	local checkwidth = function()
		local squeeze_width  = vim.fn.winwidth(0) / 2
		if squeeze_width > 40 then
			return true
		end
		return false
	end

	al {
		provider = function()
			local label = mode_labels[vim.fn.mode()]
			return " "
			--return " " .. label
		end,
		hl = function()
			local color = mode_colors[vim.fn.mode()]
			cmd ("hi! StatuslineMode ctermfg=" .. color.cterm .. " guifg=" .. color.gui .. " ctermbg=" .. colors.bg.cterm .. " guibg=" .. colors.bg.gui)
			return "StatuslineMode"
		end
	}

	al {
		provider = "file_size",
		hl = "StatuslineBackground",
		left_sep = {
			str = "  ",
			hl = "StatuslineBackground"
		},
	}

	al {
		provider = "file_info",
		type = "relative-short",
		hl = "StatuslineFileName",
		colored_icon = false, -- This as true caused problems
		left_sep = {
			str = "  ",
			hl = "StatuslineBackground"
		},
	}

	al {
		provider = "position",
		hl = "StatuslineBackground",
		left_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}

	al {
		provider = "line_percentage",
		hl = "StatuslineBackground",
		left_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}

	al {
		provider = "diagnostic_errors",
		hl = "StatuslineLSPError",
		left_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Error') end,
	}
	al {
		provider = "diagnostic_warnings",
		hl = "StatuslineLSPWarning",
		left_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Warning') end,
	}
	al {
		provider = "diagnostic_info",
		hl = "StatuslineLSPInfo",
		left_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Information') end,
	}

	al {
		provider = "diagnostic_hints",
		hl = "StatuslineLSPHint",
		left_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Hint') end,
	}

	ar {
		provider = "lsp_client_names",
		hl = "StatuslineLspClients",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}

	ar {
		provider = "git_branch",
		hl = "StatuslineGitBranch",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}

	ar {
		provider = "git_diff_added",
		hl = "StatuslineGitDiffAdded",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = "+"
	}

	ar {
		provider = "git_diff_changed",
		hl = "StatuslineGitDiffChanged",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = "~"
	}

	ar {
		provider = "git_diff_removed",
		hl = "StatuslineGitDiffRemoved",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
		icon = "-"
	}

	ar {
		provider = function()
			return vim.bo.fileformat
		end,
		hl = "StatuslineFileFormat",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}

	ar {
		provider = "file_encoding",
		hl = "StatuslineEncoding",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}

	ar {
		provider = "file_type",
		hl = "StatuslineFileType",
		right_sep = {
			str = " ",
			hl = "StatuslineBackground"
		},
	}


	il {
		provider = "file_info",
		type = "relative-short",
		hl = "StatuslineFileName",
		colored_icon = false, -- This as true caused problems
		left_sep = {
			str = "  ",
			hl = "StatuslineBackground"
		},
	}

	require "feline".setup {
		components = components,
	}

end

-- Sometimes, after reloading, the highlights just don't work, so reload the bar every few autocommands
cmd "autocmd VimEnter,CursorHold * lua SetupStatusline()"
