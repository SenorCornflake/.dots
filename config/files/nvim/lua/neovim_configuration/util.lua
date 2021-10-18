local util = {}

-- Slightly easier map function
util.map = function(mode, left, right, opts) 
	opts = opts or { noremap = true, silent = true }

	vim.api.nvim_set_keymap(mode, left, right, opts)
end

util.expanduser = function(path)
	return path:gsub("~", os.getenv("HOME"))
end

util.isdir = function(path)
    local f = io.open(path, "r")
    local ok, err, code = f:read(1)
    f:close()
    return code == 21
end

-- Get both gui and cterm highlights
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

util.extract_file_name = function(path)
	return path:match("^.+/(.+)$")
end

util.split = function(source, delimiters)
	local elements = {}
	local pattern = '([^'..delimiters..']+)'
	string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end);
	return elements
end

util.scandir = function(directory)
	local cmd = assert(io.popen('ls -A ' .. directory, "r"))
	local output = cmd:read("*all")
	cmd:close()
	return util.split(output, "\n")
end

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

util.synstack = function()
  for _, i1 in ipairs(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))) do
    local i2 = vim.fn.synIDtrans(i1)
    local n1 = vim.fn.synIDattr(i1, 'name')
    local n2 = vim.fn.synIDattr(i2, 'name')
    print(n1, '->', n2)
  end
end

return util
