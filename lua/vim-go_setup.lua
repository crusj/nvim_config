require('go').setup{
	run_in_floaterm = true,
    goimport='goimports' -- gopls
}

-- 为函数或方法生成注释
-- 填充结构体
vim.cmd([[
autocmd FileType go nnoremap <silent> gfc <cmd>GoCmt<cr>
autocmd FileType go nnoremap <silent> gsf <cmd>GoFillStruct<cr>
autocmd FileType go nnoremap <silent> gst <cmd>GoAddTag<cr>
autocmd FileType go nnoremap <silent> gfp <cmd>GoFixPlurals<cr>
autocmd FileType go nnoremap <silent> ge <cmd>GoIfErr<cr>
autocmd FileType go nnoremap <silent> gfd <cmd>GoDoc<cr>
]])

-- Run gofmt + goimport on save
-- Run gofmt on save
-- vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() ]], false)
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

