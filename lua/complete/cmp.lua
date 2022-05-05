local cmp = require('cmp')
require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")
local compare = require('cmp.config.compare')

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000;
	max_num_results = 5;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		NvimTree = true,
		["structrue-go"] = true,
		spectre_panel = true
	};
	show_prediction_strength = false;
})


local lspkind = require('lspkind')
lspkind.init({
	symbol_map = {
		TN = ""
	}
})

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function regCmp()
	require('cmp').setup({
		sorting = {
			comparators = {
				require('cmp_tabnine.compare'),
				compare.offset,
				compare.exact,
				compare.score,
				compare.recently_used,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
			},
		},
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = {
			['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			['<CR>'] = function(fallback)
				if cmp.visible() then
					cmp.confirm()
				else
					fallback() -- If you are using vim-endwise, this fallback function will be behaive as the vim-endwise.
				end
			end,
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			[';'] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i" }),
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
		},
		sources = cmp.config.sources({
			{
				name = 'nvim_lua'
			},
			{
				name = 'nvim_lsp',
			},
			{
				name = 'luasnip',

			},
			{
				name = 'cmp_tabnine'
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
				before = function(entry, vim_item)
					if entry.source.name == 'cmp_tabnine' then
						if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
							vim_item.menu = entry.completion_item.data.detail
							vim_item.kind = "TN"
						end
					end

					return vim_item
				end
			})
		},
		preselect = cmp.PreselectMode.None,
	})
end

regCmp()
