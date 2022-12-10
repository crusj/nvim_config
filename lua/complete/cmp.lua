local cmp = require('cmp')
local lspkind = require('lspkind')

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


local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 40
local MIN_LABEL_WIDTH = 40
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
    luasnip = "[SNP]",
}

local symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
    TN = "",
}

for i = 1, 100, 1 do
    local percentStr = i .. ""
    if i < 10 then
        percentStr = " " .. percentStr
    end

    local tmp = string.format("TN[%s%%]", percentStr)
    symbol_map[tmp] = ""
end

cmp.setup({
    matching = {
        disallow_prefix_unmatching = true
    },
    experimental = {
        ghost_text = false,
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
            name = 'nvim_lsp_signature_help',
        },
        {
            name = 'nvim_lsp',
        },
        {
            name = 'nvim_lua'
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
        },
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function(entry, vim_item)
                -- local label = vim_item.abbr
                -- local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
                -- if truncated_label ~= label then
                --     vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
                -- elseif string.len(label) < MIN_LABEL_WIDTH then
                --     vim_item.abbr = label .. string.rep(' ', MIN_LABEL_WIDTH - string.len(label))
                -- end
                -- return vim_item
                -- vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})


                vim_item.menu = source_mapping[entry.source.name]
                if entry.source.name == "cmp_tabnine" then
                    local detail = (entry.completion_item.data or {}).detail
                    vim_item.kind = "TN"
                    if detail and detail:find('.*%%.*') then
                        vim_item.kind = vim_item.kind .. '[' .. detail .. ']'
                    end

                    if (entry.completion_item.data or {}).multiline then
                        vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                    end
                end

                local maxwidth = 80
                vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

                return vim_item
            end,
            symbol_map = symbol_map,
        })
    },
    preselect = cmp.PreselectMode.None,
})
