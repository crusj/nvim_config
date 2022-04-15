-- editor
vim.cmd([[
set nohlsearch
]])

-- neovide
vim.cmd([[let g:neovide_cursor_vfx_mode = "pixiedust"]])
vim.cmd([[let g:neovide_remember_window_size = v:true]])
vim.cmd([[let g:cursorword_delay = 100]])

-- golang
-- 为golang函数生成注释: // functionName is 
-- 为golang方法生成注释: // methodName is 
-- 为golang当前行生成注释: // 
-- 跳转到方法或函数的签名行
-- 为struct生成方法
vim.cmd([[
autocmd FileType go nnoremap <silent> gfc ^wve"+yO// <esc>"+pa is 
autocmd FileType go nnoremap <silent> gmc ^f)wve"+yO// <esc>"+pa is 
autocmd FileType go nnoremap <silent> gbc O// 
autocmd FileType go nnoremap <silent> gac A //  
autocmd FileType go nnoremap <silent> zf ?^func<cr>zz
autocmd FileType go nnoremap <silent> gsm ^wv"ryve"+yf{%o<cr>func (*<esc>"+pa) name {<cr>}<esc>kf(a<esc>"rp~i <esc>/name<cr>ce
]])


