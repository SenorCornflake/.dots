local  M = {}

local statusline = ""

local function fn(item, minwid, maxwid)
	minwid = minwid or ""
	maxwid = maxwid or ""
	statusline = statusline..[[%]]..minwid..[[.]]..maxwid..[[{luaeval('require("config.statusline").]]..item..[[()')}]]
end

local function text(item)
	statusline = statusline..'%{"'..item..'"}'
end

local function hi(item)
	statusline = statusline..'%#'..item..'#'
end


local ghp = function(name)
	local output = vim.api.nvim_exec(":silent highlight "..name, true)

	local parameters = {}

	parameters.ctermfg = output:gmatch("ctermfg=[a-zA-Z0-9#]+")() or ""
	parameters.ctermbg = output:gmatch("ctermbg=[a-zA-Z0-9#]+")() or ""
	parameters.guifg = output:gmatch("guifg=[a-zA-Z0-9#]+")() or ""
	parameters.guibg = output:gmatch("guibg=[a-zA-Z0-9#]+")() or ""

	parameters.ctermfg = parameters.ctermfg:gsub("ctermfg=", "")
	parameters.ctermbg = parameters.ctermbg:gsub("ctermbg=", "")
	parameters.guifg = parameters.guifg:gsub("guifg=", "")
	parameters.guibg = parameters.guibg:gsub("guibg=", "")

	return parameters
end

M.mode = function()
	local mode = vim.fn.mode()
	local text = {
		['n']  = 'NORMAL',
		['no'] = 'N·Operator Pending',
		['v']  = 'VISUAL',
		['V']  = 'V·Line',
		[''] = 'V·Block',
		['s']  = 'Select',
		['S']  = 'S·Line',
		['^S'] = 'S·Block',
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

	local functionhl = ghp('Function')
	local stringhl = ghp('String')
	local constant = ghp('Constant')
	local keyword = ghp('Keyword')
	local ignore = ghp("Ignore")

	local color = {
		['n']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, functionhl.ctermfg, ignore.guifg, functionhl.guifg),
		['no'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, functionhl.ctermfg, ignore.guifg, functionhl.guifg),
		['v']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, keyword.ctermfg,    ignore.guifg, keyword.guifg),
		['V']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, keyword.ctermfg,    ignore.guifg, keyword.guifg),
		['^V'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, keyword.ctermfg,    ignore.guifg, keyword.guifg),
		['s']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, keyword.ctermfg,    ignore.guifg, keyword.guifg),
		['S']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, keyword.ctermfg,    ignore.guifg, keyword.guifg),
		['^S'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, keyword.ctermfg,    ignore.guifg, keyword.guifg),
		['i']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, stringhl.ctermfg,   ignore.guifg, stringhl.guifg),
		['ic'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, stringhl.ctermfg,   ignore.guifg, stringhl.guifg),
		['ix'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, stringhl.ctermfg,   ignore.guifg, stringhl.guifg),
		['R']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['Rv'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['c']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['cv'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['ce'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['r']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['rm'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['r?'] = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['!']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
		['t']  = string.format("ctermfg=%s ctermbg=%s guifg=%s guibg=%s", ignore.ctermfg, constant.ctermfg,   ignore.guifg, constant.guifg),
	}

	if mode ~= "c" then
		vim.cmd(":highlight clear ViMode")
	end

	if color[mode] and mode ~= "c" then
		vim.cmd(":highlight ViMode "..color[mode])
	elseif mode ~= "c" then
		vim.cmd(":silent highlight link ViMode Error")
	end

	return text[mode] or mode
end

M.file = function()
	local home = os.getenv("HOME")
	local dir = vim.fn.expand("%:h"):gsub(home, "~")
	local file = vim.fn.expand("%:t")

	if file:len() > 0 then
		return dir.."/"..file
	end

	return dir
end

M.lineinfo = function()
	return vim.fn.line(".")..":"..vim.fn.col(".")
end

M.filetype = function()
	return vim.bo.filetype
end

M.load = function()
	statusline = ""

	hi("ViMode")
	text(" ")
	fn("mode")
	text(" ")
	hi("CursorLine")
	text(" ")
	fn("file")

	-- Align right from now on
	statusline = statusline.."%="
	hi("Cursor")
	text(" ")
	fn("lineinfo")
	text(":")
	fn("filetype")
	text(" ")

	vim.wo.statusline = statusline
end

local events = {
	'ColorScheme',
	'FileType',
	'BufWinEnter',
	'BufReadPost',
	'BufWritePost',
	'BufEnter',
	'WinEnter',
	'VimEnter',
	'FileChangedShellPost',
	'VimResized',
	'TermOpen'
}
vim.api.nvim_command('augroup statusline')
vim.api.nvim_command('autocmd!')

for _, e in ipairs(events) do
	local cmd = 'autocmd '..e..' * lua require("config.statusline").load()'
	vim.cmd(cmd)
end

vim.cmd 'autocmd WinLeave * setlocal statusline='
vim.api.nvim_command('augroup END')

M.load()



return M
