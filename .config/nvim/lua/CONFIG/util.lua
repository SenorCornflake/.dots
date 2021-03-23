local util = {}

--------------------
-- MANAGE OPTIONS --
--------------------
util.O = function (opt, value)
	vim.o[opt] = value
end

util.W = function (opt, value)
	vim.wo[opt] = value
end

-- For options that also need to be set as global, same applies to the BO function
util.WO = function (opt, value)
	vim.o[opt] = value
	vim.wo[opt] = value
end

util.B = function (opt, value)
	vim.bo[opt] = value
end

util.BO = function (opt, value)
	vim.o[opt] = value
	vim.bo[opt] = value
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
		elseif fallback_colors then
			if text:gmatch("fg")() then
				return "white"
			else
				return "black"
			end
		else
			return nil
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

return util
