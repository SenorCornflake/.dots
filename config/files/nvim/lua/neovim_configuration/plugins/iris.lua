local json = require "neovim_configuration.lib.json"

require "iris".setup {
	callbacks = {
		function (pal)
			local capture = function (cmd, raw)
				local f = assert(io.popen(cmd, 'r'))
				local s = assert(f:read('*a'))
				f:close()
				if raw then return s end
				s = string.gsub(s, '^%s+', '')
				s = string.gsub(s, '%s+$', '')
				s = string.gsub(s, '[\n\r]+', ' ')
				return s
			end

			local base16 = {}

			for k, v in pairs(pal) do
				if k:find("base") then
					base16[k] = v:gsub("#", "")
				end
			end

			base16["author"] = "Neovim"
			base16["scheme"] = vim.g.colors_name

			local base16_json = json.encode(base16)
			print(vim.inspect(base16_json))

			io.open(os.getenv("DOT_ROOT") .. "/scripts/storage/base16.json", "w"):write(base16_json)
			-- For some reason os.execute doesn't work here
			capture("cat $DOT_ROOT/scripts/storage/base16.json | yq -y > $DOT_ROOT/scripts/storage/base16.yaml", true)
			--os.execute("sh $DOT_ROOT/scripts/setup_base16.sh")
		end
	},
	autocmd = false
}
