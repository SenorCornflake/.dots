local util = {}

-- Slightly easier map function
util.map = function(mode, left, right, opts) 
	opts = opts or { noremap = true, silent = true }

	vim.api.nvim_set_keymap(mode, left, right, opts)
end

-- Expand home directory
util.expanduser = function(path)
	return path:gsub("~", os.getenv("HOME"))
end

-- Chech if file is directory
util.isdir = function(path)
	local f = io.open(path, "r")
	local ok, err, code = f:read(1)
	f:close()
	return code == 21
end

-- Get both gui and cterm colors of highlight groups ( with fallback support )
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

-- File exists
util.file_exists = function(path)
	local f = io.open(path, "r")
	return f ~= nil and io.close(f)
end

-- Get the file name from path ( with extension )
util.extract_file_name = function(path)
	return path:match("^.+/(.+)$")
end

-- Split a string into a table
util.split = function(source, delimiters)
	local elements = {}
	local pattern = '([^'..delimiters..']+)'
	string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
	return elements
end

-- List the files in a directory
util.scandir = function(directory)
	local cmd = assert(io.popen('ls -A ' .. directory, "r"))
	local output = cmd:read("*all")
	cmd:close()
	return util.split(output, "\n")
end

-- Generate a base16 theme using highlights from the current theme
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

-- Print the name of the highlight group under the cursor
util.synstack = function()
	for _, i1 in ipairs(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))) do
		local i2 = vim.fn.synIDtrans(i1)
		local n1 = vim.fn.synIDattr(i1, 'name')
		local n2 = vim.fn.synIDattr(i2, 'name')
		print(n1, '->', n2)
	end
end

-- Return a list of colorschemes
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

-- Color manipulation, found it in bufferlines source
---Convert a hex color to rgb
util.hex_to_rgb = function(color)
  local hex = color:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

---@source https://stackoverflow.com/q/5560248
---@see: https://stackoverflow.com/a/37797380
---Darken a specified hex color
util.shade_color = function(color, percent)
	local alter = function(attr, percent)
		return math.floor(attr * (100 + percent) / 100)
	end

	local r, g, b = util.hex_to_rgb(color)
		if not r or not g or not b then
	return "NONE"
	end
	r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
	r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
	return string.format("#%02x%02x%02x", r, g, b)
end

--- Determine whether to use black or white text
--- References:
--- 1. https://stackoverflow.com/a/1855903/837964
--- 2. https://stackoverflow.com/a/596243
util.color_is_bright = function(hex, control)
	control = control or 0.5
	if not hex then
		return false
	end
	local r, g, b = util.hex_to_rgb(hex)
	-- If any of the colors are missing return false
	if not r or not g or not b then
		return false
	end
	-- Counting the perceptive luminance - human eye favors green color
	local luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
	return luminance > control -- if > 0.5 Bright colors, black font, otherwise Dark colors, white font
end

return util
