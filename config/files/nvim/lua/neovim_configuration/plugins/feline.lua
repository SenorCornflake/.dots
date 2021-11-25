local util = require "neovim_configuration.util"
local cmd = vim.cmd
local lsp = require('feline.providers.lsp')

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

	StatuslineColors = {
		bg = util.get_color(
			{
				{ "Normal", "bg" },
			}
		),
		alt_bg = util.get_color(
			{
				{ "StatusLine", "bg" },
			}
		),
		fg = util.get_color(
			{
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

	cmd ("hi! StatuslineBackground ctermfg="      .. StatuslineColors.fg.cterm        .. " guifg=" .. StatuslineColors.fg.gui        .. " ctermbg=" .. StatuslineColors.bg.cterm .. " guibg=" .. StatuslineColors.bg.gui)
	cmd ("hi! StatuslineAltBackground ctermfg="      .. StatuslineColors.fg.cterm        .. " guifg=" .. StatuslineColors.fg.gui        .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineAltBackgroundSymbol ctermfg="      .. StatuslineColors.alt_bg.cterm        .. " guifg=" .. StatuslineColors.alt_bg.gui        .. " ctermbg=" .. StatuslineColors.bg.cterm .. " guibg=" .. StatuslineColors.bg.gui)
	cmd ("hi! StatuslineBackgroundSymbol ctermfg="      .. StatuslineColors.bg.cterm        .. " guifg=" .. StatuslineColors.bg.gui        .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineFileName ctermfg="      .. StatuslineColors.filename.cterm        .. " guifg=" .. StatuslineColors.filename.gui        .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineEncoding ctermfg="      .. StatuslineColors.other_fg.cterm        .. " guifg=" .. StatuslineColors.other_fg.gui        .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineFileFormat ctermfg="    .. StatuslineColors.other_fg.cterm        .. " guifg=" .. StatuslineColors.other_fg.gui        .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineFileType ctermfg="    .. StatuslineColors.other_fg.cterm        .. " guifg=" .. StatuslineColors.other_fg.gui        .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)

	cmd ("hi! StatuslineLSPError ctermfg="      .. StatuslineColors.error.cterm           .. " guifg=" .. StatuslineColors.error.gui           .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineLSPWarn ctermfg="       .. StatuslineColors.warn.cterm            .. " guifg=" .. StatuslineColors.warn.gui            .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineLSPInfo ctermfg="       .. StatuslineColors.info.cterm            .. " guifg=" .. StatuslineColors.info.gui            .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineLSPHint ctermfg="       .. StatuslineColors.hint.cterm            .. " guifg=" .. StatuslineColors.hint.gui            .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineLSPClients ctermfg="    .. StatuslineColors.fg.cterm     .. " guifg=" .. StatuslineColors.fg.gui     .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)

	cmd ("hi! StatuslineGitBranch ctermfg="    .. StatuslineColors.git_branch.cterm     .. " guifg=" .. StatuslineColors.git_branch.gui     .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineGitDiffAdded ctermfg="    .. StatuslineColors.git_diff_added.cterm     .. " guifg=" .. StatuslineColors.git_diff_added.gui     .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineGitDiffChanged ctermfg="    .. StatuslineColors.git_diff_changed.cterm     .. " guifg=" .. StatuslineColors.git_diff_changed.gui     .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	cmd ("hi! StatuslineGitDiffRemoved ctermfg="    .. StatuslineColors.git_diff_removed.cterm     .. " guifg=" .. StatuslineColors.git_diff_removed.gui     .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)


	StatuslineModeColors = {
		['n']  = StatuslineColors.normal,
		['no'] = StatuslineColors.normal,

		['v']  = StatuslineColors.visual,
		['V']  = StatuslineColors.visual,
		[''] = StatuslineColors.visual,
		['s']  = StatuslineColors.visual,
		['S']  = StatuslineColors.visual,
		[''] = StatuslineColors.visual,

		['i']  = StatuslineColors.insert,
		['ic'] = StatuslineColors.insert,
		['ix'] = StatuslineColors.insert,

		['R']  = StatuslineColors.other,
		['Rv'] = StatuslineColors.other,
		['c']  = StatuslineColors.other,
		['cv'] = StatuslineColors.other,
		['ce'] = StatuslineColors.other,
		['r']  = StatuslineColors.other,
		['rm'] = StatuslineColors.other,
		['r?'] = StatuslineColors.other,
		['!']  = StatuslineColors.other,
		['t']  = StatuslineColors.other,
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

	local update_mode_color = function()
		local color = StatuslineModeColors[vim.fn.mode()]
		cmd ("hi! StatuslineMode ctermfg=" .. StatuslineColors.bg.cterm .. " guifg=" .. StatuslineColors.bg.gui .. " ctermbg=" .. color.cterm .. " guibg=" .. color.gui)
		cmd ("hi! StatuslineModeSymbol ctermfg=" .. color.cterm .. " guifg=" .. color.gui .. " ctermbg=" .. StatuslineColors.alt_bg.cterm .. " guibg=" .. StatuslineColors.alt_bg.gui)
	end

	al {
		provider = function()
			local label = mode_labels[vim.fn.mode()]
			return " " .. label .. " "
			--return "  "
		end,
		hl = function()
			update_mode_color()
			return "StatuslineMode"
		end
	}

	al {
		provider = function()
			return ""
		end,
		hl = function()
			return "StatuslineModeSymbol"
		end
	}

	al {
		provider = "file_size",
		hl = "StatuslineAltBackground",
		left_sep = {
			str = "  ",
			hl = "StatuslineAltBackground"
		},
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	al {
		provider = function()
			return ""
		end,
		hl = function()
			return "StatuslineAltBackgroundSymbol"
		end
	}

	al {
		provider = "file_info",
		type = "relative-short",
		hl = "StatuslineFileName",
		colored_icon = false, -- This as true caused problems
		left_sep = {
			str = " ",
			hl = "StatuslineBackgroundSymbol"
		},
		right_sep = {
			str = "",
			hl = "StatuslineAltBackgroundSymbol"
		},
	}

	al {
		provider = function()
			return ""
		end,
		hl = "StatuslineAltBackgroundSymbol"
	}

	al {
		provider = "position",
		hl = "StatuslineAltBackground",
		left_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	al {
		provider = "line_percentage",
		hl = "StatuslineAltBackground",
		left_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	al {
		provider = function()
			return ""
		end,
		hl = "StatuslineAltBackgroundSymbol"
	}


	ar {
		provider = function()
			return ""
		end,
		hl = "StatuslineAltBackgroundSymbol"
	}

	ar {
		provider = "lsp_client_names",
		hl = "StatuslineLspClients",
		left_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	ar {
		provider = "diagnostic_hints",
		hl = "StatuslineLSPHint",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Hint') end,
	}

	ar {
		provider = "diagnostic_errors",
		hl = "StatuslineLSPError",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Error') end,
	}

	ar {
		provider = "diagnostic_warnings",
		hl = "StatuslineLSPWarn",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Warning') end,
	}

	ar {
		provider = "diagnostic_info",
		hl = "StatuslineLSPInfo",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = " ",
		enabled = function() return lsp.diagnostics_exist('Information') end,
	}

	ar {
		provider = function()
			return ""
		end,
		hl = "StatuslineBackgroundSymbol"
	}

	ar {
		provider = function()
			return ""
		end,
		hl = "StatuslineAltBackgroundSymbol"
	}

	ar {
		provider = "git_branch",
		hl = "StatuslineGitBranch",
		left_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	ar {
		provider = "git_diff_added",
		hl = "StatuslineGitDiffAdded",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = "+"
	}

	ar {
		provider = "git_diff_changed",
		hl = "StatuslineGitDiffChanged",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = "~"
	}

	ar {
		provider = "git_diff_removed",
		hl = "StatuslineGitDiffRemoved",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		icon = "-"
	}

	ar {
		provider = function()
			return ""
		end,
		hl = "StatuslineBackgroundSymbol"
	}

	ar {
		provider = function()
			return ""
		end,
		hl = "StatuslineAltBackgroundSymbol"
	}

	ar {
		provider = function()
			return vim.bo.fileformat
		end,
		hl = "StatuslineFileFormat",
		left_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	ar {
		provider = "file_encoding",
		hl = "StatuslineEncoding",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}

	ar {
		provider = "file_type",
		hl = "StatuslineFileType",
		right_sep = {
			str = " ",
			hl = "StatuslineAltBackground"
		},
	}


	il {
		provider = "file_info",
		type = "relative-short",
		hl = "StatuslineFileName",
		colored_icon = false, -- This as true caused problems
		left_sep = {
			str = "  ",
			hl = "StatuslineAltBackground"
		},
	}

	require "feline".setup {
		components = components,
	}

end

-- Sometimes, after reloading, the highlights just don't work, so reload the bar every few autocommands
cmd "autocmd VimEnter,CursorHold * lua SetupStatusline()"
