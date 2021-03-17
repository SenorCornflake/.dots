local gl = require("galaxyline")
local gls = gl.section

local M = {}

-- Get color codes from highlights
local gh = function(highlight)
	local output = vim.api.nvim_exec(":hi "..highlight, true)

	local remove = function(text, string)
		if string then
			return string:gsub(text, "")
		else
			return false
		end
	end

	local ctermfg = remove("ctermfg=", output:gmatch("ctermfg=[a-zA-Z0-9#]*")())
	local ctermbg = remove("ctermbg=", output:gmatch("ctermbg=[a-zA-Z0-9#]*")())
	local guifg = remove("guifg=", output:gmatch("guifg=[a-zA-Z0-9#]*")())
	local guibg = remove("guibg=", output:gmatch("guibg=[a-zA-Z0-9#]*")())

	return {
		ctermfg = ctermfg,
		ctermbg = ctermbg,
		guifg = guifg,
		guibg = guibg
	}
end

M.setup = function()
	local colors = {
		normal_mode = {gh("Function"   ).guifg, gh("Function"  ).ctermfg},
		insert      = {gh("String"     ).guifg, gh("String"    ).ctermfg},
		visual      = {gh("Keyword"    ).guifg, gh("Keyword"   ).ctermfg},
		other       = {gh("Constant"   ).guifg, gh("Constant"  ).ctermfg},
		bg          = {gh("StatusLine" ).guibg, gh("StatusLine").ctermbg},
		error       = {gh("ErrorMsg"   ).guifg, gh("ErrorMsg"  ).ctermfg},
		warn        = {gh("Tag"        ).guifg, gh("Tag"       ).ctermfg},
		info        = {gh("Function"   ).guifg, gh("Function"  ).ctermfg},
		hint        = {gh("Special"    ).guifg, gh("Special"   ).ctermfg},
		normal      = {gh("Normal"     ).guifg, gh("Normal"    ).ctermfg}
	}

	-- I set the colors for the highlight groups because when I reload neovim with a different colorscheme, it doesn't refresh the statusbar's colors (I spent quite a few minutes aligning this, was worth it though)
	-- vim.cmd(":hi ViModeSeparator       guifg=bg                     guibg="..colors.bg[1].." ctermfg=bg                     ctermbg="..colors.bg[2])
	-- vim.cmd(":hi GalaxyFileName        guifg="..colors.normal[1].." guibg="..colors.bg[1].." ctermfg="..colors.normal[2].." ctermbg="..colors.bg[2])
	-- vim.cmd(":hi GalaxyLineColumn      guifg="..colors.normal[1].." guibg="..colors.bg[1].." ctermfg="..colors.normal[2].." ctermbg="..colors.bg[2])
	vim.cmd(":hi GalaxyDiagnosticError guifg="..colors.error [1].." guibg="..colors.bg[1].." ctermfg="..colors.error [2].." ctermbg="..colors.bg[2].." gui=underline cterm=underline")
	vim.cmd(":hi GalaxyDiagnosticWarn  guifg="..colors.warn  [1].." guibg="..colors.bg[1].." ctermfg="..colors.warn  [2].." ctermbg="..colors.bg[2].." gui=underline cterm=underline")
	vim.cmd(":hi GalaxyDiagnosticInfo  guifg="..colors.info  [1].." guibg="..colors.bg[1].." ctermfg="..colors.info  [2].." ctermbg="..colors.bg[2].." gui=underline cterm=underline")
	vim.cmd(":hi GalaxyDiagnosticHint  guifg="..colors.hint  [1].." guibg="..colors.bg[1].." ctermfg="..colors.hint  [2].." ctermbg="..colors.bg[2].." gui=underline cterm=underline")

	local mode_color = {
		['n']  = {colors.normal_mode[1], colors.normal_mode[2]},
		['no'] = {colors.normal_mode[1], colors.normal_mode[2]},
		['v']  = {colors.visual     [1], colors.visual     [2]},
		['V']  = {colors.visual     [1], colors.visual     [2]},
		[''] = {colors.visual     [1], colors.visual     [2]},
		['s']  = {colors.visual     [1], colors.visual     [2]},
		['S']  = {colors.visual     [1], colors.visual     [2]},
		[''] = {colors.visual     [1], colors.visual     [2]},
		['i']  = {colors.insert     [1], colors.insert     [2]},
		['ic'] = {colors.insert     [1], colors.insert     [2]},
		['ix'] = {colors.insert     [1], colors.insert     [2]},
		['R']  = {colors.other      [1], colors.other      [2]},
		['Rv'] = {colors.other      [1], colors.other      [2]},
		['c']  = {colors.other      [1], colors.other      [2]},
		['cv'] = {colors.other      [1], colors.other      [2]},
		['ce'] = {colors.other      [1], colors.other      [2]},
		['r']  = {colors.other      [1], colors.other      [2]},
		['rm'] = {colors.other      [1], colors.other      [2]},
		['r?'] = {colors.other      [1], colors.other      [2]},
		['!']  = {colors.other      [1], colors.other      [2]},
		['t']  = {colors.other      [1], colors.other      [2]}
	}

	local mode_label = {
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

	gls.left[1] = {
		Text = {
			provider = function() return " " end,
			highlight = "GalaxyViMode"
		}
	}

	gls.left[2] = {
		ViMode = {
			provider = function()
				local mode = vim.fn.mode()

				vim.cmd(":silent hi GalaxyViMode guifg=bg guibg="..mode_color[mode][1].." ctermfg=bg ctermbg="..mode_color[mode][2])

				return mode_label[mode].." "
			end,
			separator = " ",
			separator_highlight = {"NONE", colors.bg[1]}
		}
	}

	gls.left[3] = {
		FileName = {
			provider = function()
				local function file_readonly()
					if vim.bo.filetype == 'help' then
						return ''
					end
					if vim.bo.readonly == true then
						return " -RO- "
					end
					return ''
				end

				local file = vim.fn.expand('%:t')

				if vim.fn.empty(file) == 1 then return '' end

				if string.len(file_readonly()) ~= 0 then
					return file .. file_readonly()
				end

				if vim.bo.modifiable then
					if vim.bo.modified then
						return file .. ' -M- '
					end
				end
				return file .. ' '
			end,
			highlight = {colors.normal[1], colors.bg[1]}
		}
	}

	gls.left[4] = {
		LineColumn = {
			provider = "LineColumn",
			highlight = {colors.normal[1], colors.bg[1]}
		}
	}

	gls.right[1] = {
		DiagnosticError = {
			provider = 'DiagnosticError',
			icon = ' E ',
			highlight = {colors.error[1], colors.bg[1]}
		}
	}

	gls.right[2] = {
		DiagnosticWarn = {
			provider = 'DiagnosticWarn',
			icon = ' W ',
			highlight = {colors.warn[1], colors.bg[1]}
		}
	}

	gls.right[3] = {
		DiagnosticInfo = {
			provider = 'DiagnosticInfo',
			icon = ' I ',
			highlight = {colors.info[1], colors.bg[1]}
		}
	}

	gls.right[4] = {
		DiagnosticHint = {
			provider = 'DiagnosticHint',
			icon = ' H ',
			highlight = {colors.hint[1], colors.bg[1]}
		}
	}

end
M.setup()

-- Reload the statusline when color scheme is changed
vim.cmd("autocmd ColorScheme * lua require('config.statusline').setup()")

return M
