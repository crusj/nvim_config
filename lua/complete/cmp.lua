local cmp = require('cmp')
local lspkind = require('lspkind')

-- dad
vim.cmd([[
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]])

require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")
local types = require("luasnip.util.types")
luasnip.config.set_config({
	ext_opts = {
		[types.snippet] = {
			active = {
				virt_text = { { '🌈' } },
				hl_mode = "combine"
			},
		}
	}
})


-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({
-- 	max_lines = 1000;
-- 	max_num_results = 5;
-- 	sort = true;
-- 	run_on_every_keystroke = true;
-- 	snippet_placeholder = '..';
-- 	ignored_file_types = { -- default is not to ignore
-- 		NvimTree = true,
-- 		["structrue-go"] = true,
-- 		spectre_panel = true
-- 	};
-- 	show_prediction_strength = false;
-- })

lspkind.init({
	symbol_map = {
		TN = ""
	}
})

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 40
local MIN_LABEL_WIDTH = 40
cmp.setup({
	matching = {
		disallow_prefix_unmatching = true
	},
	experimental = {
		ghost_text  = false,
	},
	window = {
			completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
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
				-- elseif luasnip.expand_or_jumpable() then
				-- 	luasnip.expand_or_jump()
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
			name = 'nvim_lsp',
		},
		{
			name = 'nvim_lua'
		},
		{
			name = 'luasnip',

		},
		-- {
		--
		-- 	name = 'cmp_tabnine'
		-- },
		{
			name = 'buffer',
			option = {
				get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end
			}
		},
		{
			name = 'spell'
		},
		{
			name = 'org'
		}
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			before = function(entry, vim_item)
				local label = vim_item.abbr
				local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
				if truncated_label ~= label then
					vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
				elseif string.len(label) < MIN_LABEL_WIDTH then
					vim_item.abbr = label .. string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
				end
				return vim_item
			end,
		})
	},
	preselect = cmp.PreselectMode.None,
})

-- extension
-- cmp.setup.cmdline('/', {
-- 	sources = {
-- 		{ name = 'buffer' }
-- 	}
-- })
--
-- cmp.setup.cmdline(':', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'path' }
-- 	},
-- 		{
-- 			{ name = 'cmdline' }
-- 		})
-- })
