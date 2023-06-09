local lspconfig = require("lspconfig")

local function custom_attach(client, bufnr)
    require "lsp_signature".on_attach({
        bind                           = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts                   = {
            border = "rounded"
        },
        hint_prefix                    = '👾 ',
        floating_window                = false,
        doc_lines                      = 0,
        hint_enable                    = true,
        floating_window_above_cur_line = true,
        floating_window_off_x          = 1, -- adjust float windows x position.
        floating_window_off_y          = 1,
        max_width                      = 200,
    }, bufnr)
    vim.keymap.set('n', '<leader>fa', vim.lsp.buf.code_action, { buffer = bufnr })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- golang
lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
    settings = {
        gopls = {
            gofumpt = true
        }
    },
}

-- rust
require 'lspconfig'.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = custom_attach,
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                command = "clippy"
            }
        }
    }
}

-- lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig['lua_ls'].setup {
    capabilities = capabilities,
    on_attach = custom_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim', 'use' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                -- library = vim.api.nvim_get_runtime_file("", true),
                library = { "/Users/jianglong/.local/share/nvim/site/pack/packer/start/packer.nvim" }
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

lspconfig["phpactor"].setup {
    capabilities = capabilities,
    on_attach = custom_attach,
    init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
    }
}
