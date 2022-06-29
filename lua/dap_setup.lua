vim.cmd("hi  DapUIScope guifg=#46abf5")
vim.cmd("hi  DapUIType guifg=#D484FF")
vim.cmd("hi  DapUIModifiedValue guifg=#00F1F5 gui=bold")
vim.cmd("hi  DapUIDecoration guifg=#5fb0f5")
vim.cmd("hi  DapUIThread guifg=#A9FF68")
vim.cmd("hi  DapUIStoppedThread guifg=#46abf5")
vim.cmd("hi  DapUISource guifg=#D484FF")
vim.cmd("hi  DapUILineNumber guifg=#fadd50")
vim.cmd("hi  DapUIFloatBorder guifg=#7dcb81")
vim.cmd("hi  DapUIWatchesEmpty guifg=#F70067")
vim.cmd("hi  DapUIWatchesValue guifg=#A9FF68")
vim.cmd("hi  DapUIWatchesError guifg=#F70067")
vim.cmd("hi  DapUIBreakpointsPath guifg=#9692b9")
vim.cmd("hi  DapUIBreakpointsInfo guifg=#feb968")
vim.cmd("hi  DapUIBreakpointsCurrentLine guifg=#404b31 gui=bold")
vim.cmd("hi  link DapUIBreakpointsLine DapUILineNumber")
vim.cmd("hi  DapUIBreakpointsDisabledLine guifg=#424242")

require('dap-go').setup()

require("dapui").setup({
    mappings = {
        expand = { "o" },
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
    }
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

vim.cmd([[
highlight Breakpoint guifg=Red gui=bold
highlight DebugStop guifg=#0080FF gui=bold
]])

vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'Breakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '->', texthl = 'DebugStop', linehl = '', numhl = '' })
