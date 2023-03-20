vim.cmd([[
    imap <silent><script><expr> <A-k> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
    let g:copilot_proxy = 'http://127.0.0.1:7890'
]])
