
local cmp = require "cmp"
local luasnip = require "luasnip"
cmp.setup {
	enabled = true,
	snippet = {
		expand = function(args)
		require("luasnip").lsp_expand(args.body)
		end
	},
	mapping = {
    	['<C-d>'] = cmp.mapping.scroll_docs(-4),
    	['<C-f>'] = cmp.mapping.scroll_docs(4),
    	['<C-Space>'] = cmp.mapping.complete(),
    	['<C-e>'] = cmp.mapping.close(),
    	['<CR>'] = cmp.mapping.confirm({ select = false }),

		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
			else
				fallback()
			end
		end,
    },
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'spell' },
	},
	experimental = {
		native_menu = false,
		ghost_text = false;
	}
}
