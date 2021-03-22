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

-------------------------------
-- GET HIGHLIGHT COLOR CODES --
-------------------------------
util.gh = function(highlight)
	local output = vim.api.nvim_exec(":hi " .. highlight, true)

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