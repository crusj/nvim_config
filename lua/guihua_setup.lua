vim.cmd([[
autocmd FileType go nnoremap <silent> \q :lua require('go.term').close()<cr>
]])
