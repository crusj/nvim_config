require('dap-go').setup()

require("dapui").setup({
    mappings = {
        expand = { "o", "<2-LeftMouse>" },
        open = "<CR>",

    },
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "watches",

            },
            size = 70, -- 40 columns
            position = "left",
        },
    },
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
})

require("nvim-dap-virtual-text").setup()
vim.cmd([[
    nnoremap <silent> \1 :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> \2 :lua require'dap'.continue()<CR>
    nnoremap <silent> \3 :lua require'dap-go'.debug_test()<CR>
    nnoremap <silent> \4 :lua require'dap'.step_over()<CR>
    nnoremap <silent> \5 :lua require'dap'.step_into()<CR>
    nnoremap <silent> \6 :lua require'dap'.step_out()<CR>
    nnoremap <silent> \7 :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> \8 :lua require'dap'.run_to_cursor()<CR>
    nnoremap <silent> \9 :lua print(require'dap'.status())<CR>
    nnoremap <silent> \0 :lua require'dap'.disconnect()<CR>
    nnoremap <silent> \- :lua require'dap'.run_last()<CR>
    nnoremap <silent> \` :lua require'dapui'.toggle()<CR>
    nnoremap <silent> \. :lua require'dapui'.eval(nil, { enter = true})<CR>
]])

vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'Breakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '->', texthl = 'DebugStop', linehl = '', numhl = '' })
