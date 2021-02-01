local gl = require("galaxyline")
local gls = gl.section

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

local colors = {
	normal_mode = gh("Function").guifg,
	insert      = gh("String").guifg,
	visual      = gh("Keyword").guifg,
	other       = gh("Constant").guifg,
	bg          = gh("CursorLine").guibg,
	error       = gh("ErrorMsg").guifg,
	warn        = gh("Tag").guifg,
	info        = gh("Function").guifg,
	hint        = gh("Special").guifg,
	normal      = gh("Normal").guifg
}

-- I set the colors for the highlight groups because when I reload neovim with a different colorscheme, it doesn't refresh the statusbar's colors
vim.cmd(":hi GalaxyFileName guifg="..colors.normal.." guibg="..colors.bg)
vim.cmd(":hi GalaxyLineColumn guifg="..colors.normal.." guibg="..colors.bg)
vim.cmd(":hi GalaxyDiagnosticError guifg="..colors.error.." guibg="..colors.bg)
vim.cmd(":hi GalaxyDiagnosticWarn guifg="..colors.warn.." guibg="..colors.bg)
vim.cmd(":hi GalaxyDiagnosticInfo guifg="..colors.info.." guibg="..colors.bg)
vim.cmd(":hi GalaxyDiagnosticHint guifg="..colors.hint.." guibg="..colors.bg)

local mode_color = {
	['n']  = colors.normal_mode,
	['no'] = colors.normal_mode,
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
    ['t']  = colors.other
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

			if gh("GalaxyViMode").guibg ~= mode_color[mode] then
				vim.cmd(":silent hi GalaxyViMode guifg="..mode_color[mode].." guibg="..colors["bg"])
			end

			return mode_label[mode].." "
		end
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
		highlight = {colors.normal, colors.bg}
	}
}

gls.left[4] = {
	LineColumn = {
		provider = "LineColumn",
		highlight = {colors.normal, colors.bg}
	}
}

gls.right[1] = {
  	DiagnosticError = {
    	provider = 'DiagnosticError',
    	icon = ' E ',
		highlight = {colors.error, colors.bg}
  	}
}

gls.right[2] = {
  	DiagnosticWarn = {
    	provider = 'DiagnosticWarn',
    	icon = ' W ',
		highlight = {colors.warn, colors.bg}
  	}
}

gls.right[3] = {
  	DiagnosticInfo = {
    	provider = 'DiagnosticInfo',
    	icon = ' I ',
		highlight = {colors.info, colors.bg}
  	}
}

gls.right[4] = {
  	DiagnosticHint = {
    	provider = 'DiagnosticHint',
    	icon = ' H ',
		highlight = {colors.hint, colors.bg}
  	}
}
