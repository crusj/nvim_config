local lspkind = require('lspkind')
local function regCmp()
	local cmp = require('cmp')
	require('cmp').setup({
		snippet = {
		  -- REQUIRED - you must specify a snippet engine
		  expand = function(args)
		  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		  end,
		},
		mapping = {
		  ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		  ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		  ['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		  }),
		  ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		},
		sources = cmp.config.sources({
		  {
			  name = 'nvim_lua'
		  },
		  {
			  name = 'nvim_lsp',
		  },
		  {
			  name = 'luasnip' 
		  }, -- For luasnip users.
		  {
			  name = 'buffer'
		  },
		  {
			  name = 'spell'
		  }
		}), 
		formatting = {
			format = lspkind.cmp_format({
				mode = 'symbol_text', -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			})
		}
  })
end
regCmp()

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
