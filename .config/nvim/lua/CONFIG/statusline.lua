--[[
This can certainly be improved. I need to avoid using my hacky way of setting the highlights
--]]
local util = require("CONFIG.util")

local gl = require("galaxyline")

local left = function(item)
	table.insert(gl.section.left, item)
end

local center = function(item)
	table.insert(gl.section.mid, item)
end
local right = function(item) 
	table.insert(gl.section.right, item)
end

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

SetupStatusline = function(symbol)
	symbol = symbol or "arrow"

	if symbol == "arrow" then
		symbol = {
			left = "",
			right = ""
		}
	elseif symbol == "down_slant" then
		symbol = {
			left = "",
			right = ""
		}
	elseif symbol == "up_slant" then
		symbol = {
			left = "",
			right = ""
		}
	elseif symbol == "curve" then
		symbol = {
			left = "",
			right = ""
		}
	elseif symbol == "flame" then
		symbol = {
			left = "",
			right = ""
		}
	elseif symbol == "glitch_small" then
		symbol = {
			left = "",
			right = ""
		}
	elseif symbol == "glitch_big" then
		symbol = {
			left = "",
			right = ""
		}
	end

	-- First Reset all sections
	gl.section.left = {}
	gl.section.right = {}
	gl.section.mid = {}

	-- Get all colors {{{
	local colors = {
		bg = util.get_color(
			{
				{ "StatusLine", "bg" },
				{ "Normal", "bg" },
				{ "SignColumn", "bg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		alt_bg = util.get_color(
			{
				{ "Normal", "bg" },
				{ "StatusLine", "bg" },
				{ "SignColumn", "bg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		fg = util.get_color(
			{
				{ "Normal", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		mode_fg = util.get_color(
			{
				{ "Normal", "bg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		insert_mode = util.get_color(
			{
				{ "Function", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		normal_mode = util.get_color(
			{
				{ "String", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		visual_mode = util.get_color(
			{
				{ "Conditional", "fg" },
				{ "Keyword", "fg" },
			},
			{
				cterm = "0",
				gui = "#aa00aa"
			}
		),
		other_mode = util.get_color(
			{
				{ "Tag", "fg" },
				{ "Search", "bg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		file = util.get_color(
			{
				{ "Function", "fg" },
				{ "Include", "fg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		git_branch = util.get_color(
			{
				{ "Tag", "fg" },
				{ "Search", "bg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		diff_add = util.get_color(
			{
				{ "DiffAdded", "fg" },
				{ "DiffAdd", "fg" },
				{ "MoreMsg", "fg" },
			},
			{
				cterm = "0",
				gui = "#00aa00"
			}
		),
		diff_modified = util.get_color(
			{
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
		diff_removed = util.get_color(
			{
				{ "ErrorMsg", "fg" },
				{ "DiffRemoved", "fg" },
				{ "DiffDelete", "fg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		language_server = util.get_color(
			{
				{ "Conditional", "fg" },
				{ "Statement", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		diagnostic_error = util.get_color(
			{
				{ "LspDiagnosticsDefaultError", "fg" },
				{ "DiffRemoved", "fg" },
				{ "DiffDelete", "fg" },
				{ "ErrorMsg", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		diagnostic_warn = util.get_color(
			{
				{ "LspDiagnosticsDefaultWarning", "fg" },
				{ "Constant", "fg" },
				{ "WarningMsg", "fg"  },
				{ "Boolean", "fg" },
				{ "Delimiter", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		diagnostic_hint = util.get_color(
			{
				{ "LspDiagnosticsDefaultHint", "fg" },
				{ "Special", "fg" },
				{ "Function", "fg" },
				{ "Include", "fg" }
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
		diagnostic_info = util.get_color(
			{
				{ "LspDiagnosticsDefaultInformation", "fg" },
				{ "String", "fg" },
				{ "DiffAdded", "fg" },
				{ "DiffAdd", "fg" },
			},
			{
				cterm = "0",
				gui = "#000000"
			}
		),
	}
	-- }}}
	
	local mode_colors = {
		['n']  = colors.normal_mode,
		['no'] = colors.normal_mode,
		['v']  = colors.visual_mode, 
		['V']  = colors.visual_mode, 
		[''] = colors.visual_mode, 
		['s']  = colors.visual_mode, 
		['S']  = colors.visual_mode, 
		[''] = colors.visual_mode, 
		['i']  = colors.insert_mode, 
		['ic'] = colors.insert_mode, 
		['ix'] = colors.insert_mode, 
		['R']  = colors.other_mode,  
		['Rv'] = colors.other_mode,  
		['c']  = colors.other_mode,  
		['cv'] = colors.other_mode,  
		['ce'] = colors.other_mode,  
		['r']  = colors.other_mode,  
		['rm'] = colors.other_mode,  
		['r?'] = colors.other_mode,  
		['!']  = colors.other_mode,  
		['t']  = colors.other_mode,  
	}

	local setup_highlights = function()
		local mode = vim.fn.mode()
		vim.cmd(":silent hi GalaxyMode guifg=" .. colors.mode_fg.gui .. " guibg=" .. mode_colors[mode].gui .. " ctermfg=" .. colors.mode_fg.cterm .. " ctermbg=" .. mode_colors[mode].cterm)
		vim.cmd(":silent hi GalaxyModePowerline guifg=" .. mode_colors[mode].gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. mode_colors[mode].cterm .. " ctermbg=" .. colors.alt_bg.cterm)

		-- TODO: Avoid this
		vim.cmd(":silent hi GalaxyFileIcon guifg=" .. colors.file.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.file.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyFileName guifg=" .. colors.file.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.file.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyFileNameDecor guifg=" .. colors.alt_bg.gui .. " guibg=" .. colors.bg.gui .. " ctermfg=" .. colors.alt_bg.cterm .. " ctermbg=" .. colors.bg.cterm)
		vim.cmd(":silent hi GalaxyFileSize guifg=" .. colors.fg.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.fg.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyLineColumn guifg=" .. colors.fg.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.fg.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyLinePercent guifg=" .. colors.fg.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.fg.cterm .. " ctermbg=" .. colors.alt_bg.cterm)

		vim.cmd(":silent hi GalaxyGitBranchDecor guifg=" .. colors.alt_bg.gui .. " guibg=" .. colors.bg.gui .. " ctermfg=" .. colors.alt_bg.cterm .. " ctermbg=" .. colors.bg.cterm)
		vim.cmd(":silent hi GalaxyGitBranch guifg=" .. colors.git_branch.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.git_branch.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiffAdd guifg=" .. colors.diff_add.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diff_add.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiffModified guifg=" .. colors.diff_modified.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diff_modified.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiffRemove guifg=" .. colors.diff_removed.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diff_removed.cterm .. " ctermbg=" .. colors.alt_bg.cterm)

		vim.cmd(":silent hi GalaxyLanguageServer guifg=" .. colors.language_server.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.language_server.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiagnosticError guifg=" .. colors.diagnostic_error.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diagnostic_error.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiagnosticWarn guifg=" .. colors.diagnostic_warn.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diagnostic_warn.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiagnosticHint guifg=" .. colors.diagnostic_hint.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diagnostic_hint.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
		vim.cmd(":silent hi GalaxyDiagnosticInfo guifg=" .. colors.diagnostic_info.gui .. " guibg=" .. colors.alt_bg.gui .. " ctermfg=" .. colors.diagnostic_info.cterm .. " ctermbg=" .. colors.alt_bg.cterm)
	end

	left({
		ModeSpacing = {
			provider = function() return "" end,
			separator = " ",
			separator_highlight = "GalaxyMode",
		}
	})

	left({
		Mode = {
			provider = function()
				setup_highlights()
				local mode = vim.fn.mode()
				local label = mode_labels[mode] .. " "
				return label
			end
		}
	})

	left({
		ModePowerline = {
			provider = function() return symbol["left"] .. " " end,
		}
	})

	left({
		LineColumn = {
			provider = "LineColumn",
			separator = " ",
			separator_highlight = "GalaxyLineColumn"
		}
	})

	left({
		LinePercent = {
			provider = "LinePercent",
			separator = " ",
			separator_highlight = "GalaxyLinePercent"
		}
	})

	left({
		FileIcon = {
			provider = "FileIcon",
		}
	})

	left({
		FileName = {
			provider = "FileName",
			separator = symbol["left"],
			separator_highlight = "GalaxyFileNameDecor",
		}
	})

	right({
		GitBranchDecor = {
			provider = function() return symbol["right"] end
		}
	})

	right({
		GitBranch = {
			provider = "GitBranch",
			separator = " ",
			separator_highlight = "GalaxyGitBranch",
 			condition = require('galaxyline.condition').check_git_workspace,
			icon = " "
		}
	})

	right({
		DiffAdd = {
			provider = "DiffAdd",
			separator = " ",
			separator_highlight = "GalaxyDiffAdd",
			icon = "+",
		}
	})
	right({
		DiffModified = {
			provider = "DiffModified",
			separator = " ",
			separator_highlight = "GalaxyDiffModified",
			icon = "~",
		}
	})
	right({
		DiffRemove = {
			provider = "DiffRemove",
			separator = " ",
			separator_highlight = "GalaxyDiffRemove",
			icon = "-",
		}
	})
	
	right({
		LanguageServer = {
			provider = function()
				local active_lsp = util.active_lsp()

				if active_lsp then
					return active_lsp .. "  "
				end

				return "  "
			end,
		}
	})

	right({
		DiagnosticError = {
			provider = "DiagnosticError",
			icon = " "
		}
	})

	right({
		DiagnosticWarn = {
			provider = "DiagnosticWarn",
			icon = " "
		}
	})

	right({
		DiagnosticHint = {
			provider = "DiagnosticHint",
			icon = " "
		}
	})

	right({
		DiagnosticInfo = {
			provider = "DiagnosticInfo",
			icon = " "
		}
	})
end

return function(powerline_symbol)
	vim.cmd ("autocmd VimEnter,ColorScheme * lua SetupStatusline('" .. powerline_symbol .. "')")
	vim.cmd ("autocmd WinLeave,BufLeave * setlocal statusline=")
end
