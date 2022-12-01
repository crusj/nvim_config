-- sets
local global_options = {
	background = "light",
	termguicolors = true,
	hidden = true,
	autowrite = true,
	ignorecase = true,
	mouse = "a",
	nu = true,
	-- rnu = true,
	cursorline = true,
	clipboard = "unnamedplus",
	backspace = "indent,eol,start",
	foldmethod = "indent",
	signcolumn = "yes",
	shell = "/bin/bash",
	guifont = 'GoMono Nerd Font Mono:h14',
	expandtab = true,
    laststatus = 3,
}

for option, value in pairs(global_options) do
	vim.o[option] = value
end

--hl
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd([[
			highlight CmpItemAbbrMatch guifg=#268bd2
		]])
	end
})

-- cmds
vim.cmd([[
set sessionoptions-=blank
set nohlsearch
set splitright
let g:cursorword_disable_filetypes = ["structrue-go","bookmarks"]

set tabstop=4
set shiftwidth=4
set expandtab
]])

-- augroup
---- save fold info
vim.cmd([[
augroup remember_folds
  autocmd!
  set foldlevelstart=99
  au BufWinLeave *.go mkview 1
  au BufWinEnter *.go silent! loadview 1
augroup END

]])

-- diagnostic
vim.diagnostic.config({
	virtual_text = false,
})

vim.cmd([[
	sign define DiagnosticSignError text=⫸ texthl=DiagnosticSignError linehl= numhl=
]])

vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "", texthl = "DiagnosticSignHint" })

-- neovide
vim.cmd([[
let g:neovide_cursor_vfx_mode = "pixiedust"
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_vfx_opacity=200.0
let g:neovide_transparency=1
]])
vim.api.nvim_set_keymap("n", "<space>dk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>dj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>dd", "<cmd>lua vim.diagnostic.open_float()<cr>", { silent = true })

-- golang
-- 为golang当前行生成注释: //
-- 为golang当前行末尾生成注释: //
-- 跳转到方法或函数的签名行
-- 为struct生成方法
vim.cmd([[
autocmd FileType go nnoremap <silent> gbc O// 
autocmd FileType go nnoremap <silent> gac A //  
autocmd FileType go nnoremap <silent> zf ?^func<cr>zz
autocmd FileType go nnoremap <silent> gsm ^wv"ryve"+yf{%o<cr>func (*<esc>"+pa) name {<cr>}<esc>kf(a<esc>"rp~i <esc>/name<cr>ce
]])
