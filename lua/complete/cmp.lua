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

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
    luasnip = "[SNP]",
}

local symbol_map = {
    Text = '  ',
    Method = '󰡱  ',
    Function = '󰊕  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = "  ",
    Package = ' ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
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
        ['<A-j>'] = function()
            if cmp.visible() then
                cmp.abort()
            else
                cmp.complete()
            end
        end
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
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
                mode = 'symbol_text', -- show only symbol annotations
                maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                before = function()
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
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimemtpy = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = " " .. (strings[4] or "") .. " "

            return kind
        end
    },
    preselect = cmp.PreselectMode.None,
})


-- autopairs
require('nvim-autopairs').setup{}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
