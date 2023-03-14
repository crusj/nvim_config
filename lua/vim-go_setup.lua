require('go').setup{
	run_in_floaterm = true,
    goimport='goimports', -- gopls
    gofmt = 'gofumpt',
    lsp_gofumpt = true,
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
-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})
