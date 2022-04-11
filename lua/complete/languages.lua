local lspconfig = require("lspconfig")

local function custom_attach()
   	require "lsp_signature".on_attach({
		bind = true,
		use_lspsaga = false,
		floating_window = true,
		fix_pos = true,
		hint_enable = true,
		hi_parameter = "Search",
		handler_opts = { "double" },
	})  -- Note: add in lsp client on-attach
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

--golang
lspconfig['gopls'].setup {
   	capabilities = capabilities,
	on_attach = custom_attach
}

--lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig['sumneko_lua'].setup{
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
        globals = {'vim','use'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
