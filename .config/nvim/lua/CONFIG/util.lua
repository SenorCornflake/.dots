local util = {}

-- This file contains General Functions

--------------------
-- List directory --
--------------------
util.scandir = function(directory)
	local cmd = assert(io.popen('ls -A ' .. directory, "r"))
	local output = cmd:read("*all")
	cmd:close()
	return output
end

---------------------
-- MANAGE BINDINGS --
---------------------
util.bind = function (mode, binding, command, args)
	args = args or { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, binding, command, args)
end

-----------------------------
-- SPLIT STRING INTO TABLE --
-----------------------------
function util.split(source, delimiters)
	local elements = {}
	local pattern = '([^'..delimiters..']+)'
	string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
	return elements
end

-------------------------------
-- GET HIGHLIGHT COLOR CODES --
-------------------------------
util.gh = function(highlight, fallback_colors)
	fallback_colors = fallback_colors or true
	local output = vim.api.nvim_exec(":hi " .. highlight, true)

	if output:gmatch("cleared")() then
		if fallback_colors then
			local normal = util.gh("Normal", false)

			if normal then
				return normal
			else
				return { guifg = "white", guibg = "black", ctermfg = "white", ctermbg = "black"}
			end
		end
		return nil
	end

	if output:gmatch("links")() then
		highlight = util.split(output, " ")
		highlight = highlight[#highlight]
		output = vim.api.nvim_exec(":hi " .. highlight, true)
	end

	local remove = function(text, str)
		if str then
			return str:gsub(text, "")
		else
			return "none"
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

---------------------------
-- GET ACTIVE LSP SERVER --
---------------------------
util.active_lsp = function()
	local active_clients = vim.lsp.buf_get_clients()

	if #active_clients > 0 then
		local found = false
		local index = 0
		local active_client = nil

		while not found do
			if active_clients[index] then
				found = true
				active_client = active_clients[index]
			end

			index = index + 1
		end

		if active_client ~= nil then
			return active_client.name
		end
	end

	return nil
end

------------------------------------
-- GET A LIST OF ALL COLORSCHEMES --
------------------------------------
util.colorschemes = function(display)
	display = display or false

	local rtps = vim.o.runtimepath
	rtps = util.split(rtps, ",")

	local colorschemes = {}

	for _, rtp in pairs(rtps) do
		local colors_dir = rtp .. "/colors"

		if vim.fn.isdirectory(colors_dir) then
			for _, colorscheme in pairs(util.split(vim.fn.glob(colors_dir .. "/*.vim"), "\n")) do
				colorscheme = vim.fn.fnamemodify(colorscheme, ":t:r")
				table.insert(colorschemes, colorscheme)
			end
		end
	end

	-- Remove duplicates
	local hash = {}
	local res = {}

	for _,v in pairs(colorschemes) do
	   if not hash[v] then
		   res[#res + 1] = v
		   hash[v] = true
	   end
	end

	colorschemes = res

	if display then
		for _, colorscheme in pairs(colorschemes) do
			print(colorscheme .. "\n")
		end
	else
		return colorschemes
	end
end

-------------------------------------
-- GET THE INDEX OF VALUE IN TABLE --
-------------------------------------
util.index = function(table, value)
	for k, v in pairs(table) do
		if v == value then
			return k
		end
	end

	return nil
end

----------------------------
-- GO TO NEXT COLORSCHEME --
----------------------------
vim.cmd "autocmd User Restarted lua Current_colorscheme_index = nil"
vim.cmd "autocmd User Restarted lua Colorschemes = nil"

util.next_colorscheme = function(backward)
	if not Colorschemes then
		Colorschemes = util.colorschemes()
	end

	if not Current_colorscheme_index then
		local index = util.index(Colorschemes, vim.g.colors_name)

		if index then
			Current_colorscheme_index = index
		else
			Current_colorscheme_index = 1
		end
	end

	if backward then
		local prev = Colorschemes[Current_colorscheme_index - 1]
		if prev then
			Current_colorscheme_index = Current_colorscheme_index - 1
		else
			Current_colorscheme_index = #Colorschemes
		end
	else
		local next = Colorschemes[Current_colorscheme_index + 1]

		if next then
			Current_colorscheme_index = Current_colorscheme_index + 1
		else
			Current_colorscheme_index = 1
		end
	end

	print(Current_colorscheme_index .. "/" .. #Colorschemes .. " " .. Colorschemes[Current_colorscheme_index])
	vim.cmd("colorscheme " .. Colorschemes[Current_colorscheme_index])
end

--------------------------------------------------------
-- Generate BASE16 theme based on current colorscheme --
--------------------------------------------------------
util.base16ify = function()
	local theme = {
		scheme = vim.g.colors_name,
		author = "Generated",
		base00 = util.gh("Normal")     .guibg:gsub("#", ""),
		base01 = util.gh("CursorLine") .guibg:gsub("#", ""),
		base02 = util.gh("Visual")     .guibg:gsub("#", ""),
		base03 = util.gh("Comment")    .guifg:gsub("#", ""),
		base04 = util.gh("StatusLine") .guifg:gsub("#", ""),
		base05 = util.gh("Normal")     .guifg:gsub("#", ""),
		base06 = util.gh("StatusLine") .guifg:gsub("#", ""),
		base07 = util.gh("Normal")     .guifg:gsub("#", ""),
		base08 = util.gh("Character")  .guifg:gsub("#", ""),
		base09 = util.gh("Number")     .guifg:gsub("#", ""),
		base0A = util.gh("Type")       .guifg:gsub("#", ""),
		base0B = util.gh("String")     .guifg:gsub("#", ""),
		base0C = util.gh("Special")    .guifg:gsub("#", ""),
		base0D = util.gh("Function")   .guifg:gsub("#", ""),
		base0E = util.gh("Conditional").guifg:gsub("#", ""),
		base0F = util.gh("Constant")   .guifg:gsub("#", "")
	}

	-- Some themes don't set some highlights so we just fallback to the normal foreground
	for k, v in pairs(theme) do
		if v == "none" then
			theme[k] = util.gh("Normal").guifg:gsub("#", "")
		end
	end

	for k, base in pairs(theme) do
		if base == "none" then
			print("Failed getting color for " .. k)
		end
	end

	local text =   'scheme: "' .. theme.scheme .. '"\n'
	text = text .. 'author: "' .. theme.author .. '"\n'
	text = text .. 'base00: "' .. theme.base00 .. '"\n'
	text = text .. 'base01: "' .. theme.base01 .. '"\n'
	text = text .. 'base02: "' .. theme.base02 .. '"\n'
	text = text .. 'base03: "' .. theme.base03 .. '"\n'
	text = text .. 'base04: "' .. theme.base04 .. '"\n'
	text = text .. 'base05: "' .. theme.base05 .. '"\n'
	text = text .. 'base06: "' .. theme.base05 .. '"\n'
	text = text .. 'base07: "' .. theme.base07 .. '"\n'
	text = text .. 'base08: "' .. theme.base08 .. '"\n'
	text = text .. 'base09: "' .. theme.base09 .. '"\n'
	text = text .. 'base0A: "' .. theme.base0A .. '"\n'
	text = text .. 'base0B: "' .. theme.base0B .. '"\n'
	text = text .. 'base0C: "' .. theme.base0C .. '"\n'
	text = text .. 'base0D: "' .. theme.base0D .. '"\n'
	text = text .. 'base0E: "' .. theme.base0E .. '"\n'
	text = text .. 'base0F: "' .. theme.base0F .. '"'

	return text
end

util.adapt_system = function()
	local theme = util.base16ify()

	if theme == nil then return end

	local file = io.open(os.getenv("HOME") .. "/MAIN/tmp/base16_schemes/" .. vim.g.colors_name .. ".yaml", "w")
	file:write(theme)
	file:close()

	os.execute("python ~/MAIN/scripts/adapt_to_base16.py ~/MAIN/tmp/base16_schemes/" .. vim.g.colors_name .. ".yaml " .. vim.g.colors_name)
end

-----------------------------------------------------------------------------
-- ECHO HL GROUP NAMES OF WORD UNDER CURSOR (too lazy to remake it in lua) --
-----------------------------------------------------------------------------
vim.cmd [[
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
]]


------------------------------------------
-- List Dashboard Sessions in Telescope --
------------------------------------------
util.sessions = function()
	local sessions = util.scandir(vim.g.dashboard_session_directory)
	sessions = util.split(sessions, "\n")

	for i, session in pairs(sessions) do
		sessions[i] = session:gsub(".vim", "")
	end

	local previewers = require('telescope.previewers')
	local pickers = require('telescope.pickers')
	local sorters = require('telescope.sorters')
	local finders = require('telescope.finders')
	local actions = require('telescope.actions')
	local action_set = require('telescope.actions.set')
	local action_state = require('telescope.actions.state')

	pickers.new(opts, {
    	prompt_title = 'Sessions',
    	finder = finders.new_table(sessions),
    	sorter = sorters.get_generic_fuzzy_sorter(),
		attach_mappings = function(prompt_bufnr)
      		actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				
				vim.cmd(":SessionLoad " .. selection.display)
      		end)

      		return true
    	end,
	}):find()
end

return util
