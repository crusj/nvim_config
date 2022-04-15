local lspkind = require('lspkind')
local function regCmp()
	local cmp = require('cmp')
	require('cmp').setup({
		snippet = {
		  	expand = function(args)
		  		require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		  	end,
		},
		mapping = {
		  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		  ['<Tab>'] = cmp.mapping.confirm({ select = true }),
		  ['<C-n>'] = function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else
								fallback()
							end
    				  end,
		  ['<C-p>'] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
    				  end,
		  ['<CR>'] = cmp.mapping.confirm({ select = true })
		},
		sources = cmp.config.sources({
		  {
			  name = 'nvim_lua'
		  },
		  {
			  name = 'nvim_lsp',
		  },
		  {
			  name = 'luasnip' ,
			  priority = 100,

		  },
		  {
			  name = 'buffer',
			  option = {
       			 get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
      		  }
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
		},
		preselect = cmp.PreselectMode.None,
  })
end
regCmp()

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
