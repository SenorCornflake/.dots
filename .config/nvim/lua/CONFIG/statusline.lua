local util = require("CONFIG.util")

local gl = require("galaxyline")

local left = function(item)
	table.insert(gl.section.left, item)
end

local right = function(item)
	table.insert(gl.section.right, item)
end

SetupStatusline = function(symbol)
	symbol = symbol or "arrow"

	if symbol == "arrow" then
		symbol = ""
	elseif symbol == "down_slant" then
		symbol = ""
	elseif symbol == "up_slant" then
		symbol = ""
	elseif symbol == "curve" then
		symbol = ""
	end

	-- First Reset
	gl.section.left = {}
	gl.section.right = {}

	local function_hl    = util.gh("Function")    -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local string_hl      = util.gh("String")      -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local keyword_hl     = util.gh("Keyword")     -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local constant_hl    = util.gh("Constant")    -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local statusline_hl  = util.gh("StatusLine")  -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local errormsg_hl    = util.gh("ErrorMsg")    -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local tag_hl         = util.gh("Tag")         -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local special_hl     = util.gh("Special")     -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local normal_hl      = util.gh("Normal")      -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}
	local conditional_hl = util.gh("Conditional") -- or { guifg = "#ffffff", guibg = "#000000", ctermfg = "#ffffff", ctermbg = "#000000"}

	local colors = {
		normal_mode = { function_hl   .guifg , function_hl   .ctermfg },
		insert      = { string_hl     .guifg , string_hl     .ctermfg },
		visual      = { keyword_hl    .guifg , keyword_hl    .ctermfg },
		other       = { constant_hl   .guifg , constant_hl   .ctermfg },
		bg          = { normal_hl     .guibg , normal_hl     .ctermbg },
		error       = { errormsg_hl   .guifg , errormsg_hl   .ctermfg },
		warn        = { tag_hl        .guifg , tag_hl        .ctermfg },
		info        = { function_hl   .guifg , function_hl   .ctermfg },
		hint        = { special_hl    .guifg , special_hl    .ctermfg },
		normal      = { normal_hl     .guifg , normal_hl     .ctermfg },
		git         = { constant_hl   .guifg , constant_hl   .ctermfg },
	}

	local mode_colors = {
		['n']  = { colors.normal_mode[1], colors.normal_mode[2] },
		['no'] = { colors.normal_mode[1], colors.normal_mode[2] },
		['v']  = { colors.visual     [1], colors.visual     [2] },
		['V']  = { colors.visual     [1], colors.visual     [2] },
		[''] = { colors.visual     [1], colors.visual     [2] },
		['s']  = { colors.visual     [1], colors.visual     [2] },
		['S']  = { colors.visual     [1], colors.visual     [2] },
		[''] = { colors.visual     [1], colors.visual     [2] },
		['i']  = { colors.insert     [1], colors.insert     [2] },
		['ic'] = { colors.insert     [1], colors.insert     [2] },
		['ix'] = { colors.insert     [1], colors.insert     [2] },
		['R']  = { colors.other      [1], colors.other      [2] },
		['Rv'] = { colors.other      [1], colors.other      [2] },
		['c']  = { colors.other      [1], colors.other      [2] },
		['cv'] = { colors.other      [1], colors.other      [2] },
		['ce'] = { colors.other      [1], colors.other      [2] },
		['r']  = { colors.other      [1], colors.other      [2] },
		['rm'] = { colors.other      [1], colors.other      [2] },
		['r?'] = { colors.other      [1], colors.other      [2] },
		['!']  = { colors.other      [1], colors.other      [2] },
		['t']  = { colors.other      [1], colors.other      [2] }
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

	local update_symbol_color = function(color_g, color_t)
		vim.cmd (":hi GalaxyModePowerline guifg=" ..  color_g .. " ctermfg=" .. color_t)
	end

	left({
		Mode = {
			provider = function()
				local mode = vim.fn.mode()

				vim.cmd(":silent hi GalaxyMode guifg=" .. colors.bg[1] .. " guibg=" .. mode_colors[mode][1] .. " ctermfg=" .. colors.bg[2] .. " ctermbg=" .. mode_colors[mode][2])

				update_symbol_color(mode_colors[mode][1], mode_colors[mode][2])

				-- I know, you're thinking "Why is this here?", well, the reason is that if I place it anywhere else it doesn't work unless I call SetupStatusline() manually
				-- So I put it here because this works
				vim.cmd ("hi GalaxyFileIcon guifg=" .. colors.warn[1] .. " ctermfg=" .. colors.warn[2])
				vim.cmd ("hi GalaxyFileName guifg=" .. colors.warn[1] .. " ctermfg=" .. colors.warn[2])

				vim.cmd ("hi GalaxyGitIcon guifg=" .. colors.git[1] .. " ctermfg=" .. colors.git[2])
				vim.cmd ("hi GalaxyGitBranch guifg=" .. colors.git[1] .. " ctermfg=" .. colors.git[2])

				vim.cmd ("hi GalaxyLanguageServer guifg=" .. colors.insert[1] .. " ctermfg=" .. colors.insert[2])

				vim.cmd ("hi GalaxyDiagnosticError guifg=" .. colors.error[1] .. " ctermfg=" .. colors.error[2])
				vim.cmd ("hi GalaxyDiagnosticWarn guifg=" .. colors.warn[1] .. " ctermfg=" .. colors.warn[2])
				vim.cmd ("hi GalaxyDiagnosticInfo guifg=" .. colors.info[1] .. " ctermfg=" .. colors.info[2])
				vim.cmd ("hi GalaxyDiagnosticHint guifg=" .. colors.hint[1] .. " ctermfg=" .. colors.hint[2])

				local label = "  " .. mode_labels[mode] .. " "
				return label
			end
		}
	})

	left({
		ModePowerline = {
			provider = function() return symbol end,
			separator = " ",
		}
	})

	left({
		FileSize = {
			provider = "FileSize",
			separator = " ",
			separator_highlight = "NONE"
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
			separator = " ",
			separator_highlight = "NONE"
		}
	})

	left({
		LineColumn = {
			provider = "LineColumn",
			separator = " ",
			separator_highlight = "NONE"
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
			end
		}
	})

	right({
		DiagnosticError = {
			provider = 'DiagnosticError',
			icon = '  ',
		}
	})

	right({
		DiagnosticWarn = {
			provider = 'DiagnosticWarn',
			icon = '  ',
		}
	})

	right({
		DiagnosticInfo = {
			provider = 'DiagnosticInfo',
			icon = '  ',
		}
	})

	right({
		DiagnosticHint = {
			provider = 'DiagnosticHint',
			icon = '  ',
		}
	})


	right({
		GitIcon = {
			provider = function() return ' ' end,
			condition = require('galaxyline.condition').check_git_workspace,
			separator = ' ',
		},
	})

	right({
		GitBranch = {
			provider = 'GitBranch',
			condition = require('galaxyline.condition').check_git_workspace,
		},
	})

end

return function(powerline_symbol)
	vim.cmd ("autocmd VimEnter * lua SetupStatusline('" .. powerline_symbol .. "')")
	vim.cmd ("autocmd ColorScheme * lua SetupStatusline('" .. powerline_symbol .. "')")
	vim.cmd ("autocmd ColorSchemePre * lua SetupStatusline('" .. powerline_symbol .. "')")
end

