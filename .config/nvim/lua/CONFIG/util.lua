local util = {}
-- This file contains General Functions


---------------------
-- MANAGE BINDINGS --
---------------------
util.bind = function(mode, binding, command, args)
	args = args or { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, binding, command, args)
end

-----------------------------
-- SPLIT STRING INTO TABLE --
-----------------------------
util.split = function(source, delimiters)
	local elements = {}
	local pattern = '([^'..delimiters..']+)'
	string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
	return elements
end

--------------------
-- List directory --
--------------------
util.scandir = function(directory)
	local cmd = assert(io.popen('ls -A ' .. directory, "r"))
	local output = cmd:read("*all")
	cmd:close()
	return util.split(output, "\n")
end

------------------
-- IS DIRECTORY --
------------------
util.isdir = function(path)
    local f = io.open(path, "r")
    local ok, err, code = f:read(1)
    f:close()
    return code == 21
end

-----------------
-- FILE EXISTS --
-----------------
util.file_exists = function(path)
	local f = io.open(path, "r")
	return f ~= nil and io.close(f)
end

---------------------
-- EXPAND HOME DIR --
---------------------
util.expanduser = function(path)
	return path:gsub("~", os.getenv("HOME"))
end

-------------------------------
-- GET HIGHLIGHT COLOR CODES --
-------------------------------
util.get_color = function(highlights, fallbacks)
	if not highlights then return end

	local output = {
		gui = "#000000",
		cterm = "0"
	}

	local get = function(name, attr, mode)
		return vim.api.nvim_exec('echo synIDattr(synIDtrans(hlID("' .. name .. '")), "' .. attr .. '#", "' .. mode .. '")', true)
	end

	-- Have seperate loops so that both cterm and gui can fallback to the next highlight on their own
	for _, h in pairs(highlights) do
		local name = h[1]
		local attr = h[2]

		local color = get(name, attr, "gui")

		if color:len() > 0 then
			output.gui = color
			break
		else
			if fallbacks then
				output.gui = fallbacks.gui
			end
		end
	end

	for _, h in pairs(highlights) do
		local name = h[1]
		local attr = h[2]

		local color = get(name, attr, "cterm")

		if color:len() > 0 then
			output.cterm = color
			break
		else
			if fallbacks then
				output.cterm = fallbacks.cterm
			end
		end
	end
	
	return output
end

---------------------------
-- GET ACTIVE LSP SERVER --
---------------------------
util.active_lsp = function()
	local active_clients = vim.lsp.buf_get_clients()
	if #active_clients > 0 then
		local index = 0
		local active_client = nil

		while true do
			if active_clients[index] then
				active_client = active_clients[index]
				break
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

		base00 = util.get_color({
			{"Normal", "bg"}
		}).gui:gsub("#", ""),

		base01 = util.get_color({
			{"CursorLine" , "bg"}
		}).gui:gsub("#", ""),

		base02 = util.get_color({
			{"Visual", "bg"},
			{"Normal", "bg"},
		}).gui:gsub("#", ""),

		base03 = util.get_color({
			{"Comment", "fg"}
		}).gui:gsub("#", ""),

		base04 = util.get_color({
			{"StatusLine", "fg"}
		}).gui:gsub("#", ""),
		
		base05 = util.get_color({
			{"Normal", "fg"}
		}).gui:gsub("#", ""),

		base06 = util.get_color({
			{"StatusLine", "fg"}
		}).gui:gsub("#", ""),

		base07 = util.get_color({
			{"Normal", "fg"}
		}).gui:gsub("#", ""),

		base08 = util.get_color({
			{"Character", "fg"}
		}).gui:gsub("#", ""),

		base09 = util.get_color({
			{"Number", "fg"}
		}).gui:gsub("#", ""),

		base0A = util.get_color({
			{"Type", "fg"}
		}).gui:gsub("#", ""),

		base0B = util.get_color({
			{"String", "fg"}
		}).gui:gsub("#", ""),

		base0C = util.get_color({
			{"Special", "fg"}
		}).gui:gsub("#", ""),

		base0D = util.get_color({
			{"Function", "fg"}
		}).gui:gsub("#", ""),

		base0E = util.get_color({
			{"Conditional", "fg"}
		}).gui:gsub("#", ""),

		base0F = util.get_color({
			{"Constant", "fg"}
		}).gui:gsub("#", "")
	}

	local  text = "\n"
	text = text .. 'scheme: "' .. theme.scheme .. '"\n'
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

-------------------------------------------------------
-- ADAPT MY SYSTEM COLORS TO THE CURRENT COLORSCHEME --
-------------------------------------------------------
util.adapt_system = function()
	local theme = util.base16ify()

	if theme == nil then return end

	local file = io.open(os.getenv("DOTFILES_BRAIN_ROOT") .. "/tmp/base16_schemes/" .. vim.g.colors_name .. ".yaml", "w")
	file:write(theme)
	file:close()

	os.execute("python $DOTFILES_BRAIN_ROOT/scripts/adapt_to_base16.py --perform-long-tasks $DOTFILES_BRAIN_ROOT/tmp/base16_schemes/" .. vim.g.colors_name .. ".yaml " .. vim.g.colors_name)
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

---------------------------------
-- Get output of shell command --
---------------------------------
util.capture = function(cmd, raw) -- From stackoverflow: https://stackoverflow.com/questions/132397/get-back-the-output-of-os-execute-in-lua
	local f = assert(io.popen(cmd, 'r'))
  	local s = assert(f:read('*a'))
  	f:close()
  	if raw then return s end
  	s = string.gsub(s, '^%s+', '')
  	s = string.gsub(s, '%s+$', '')
  	s = string.gsub(s, '[\n\r]+', ' ')
  	return s
end

return util
