vim.cmd([[
let g:indent_blankline_char_blankline = '┊'
let g:indent_blankline_char = '┊'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_indent_level = 4
let g:indent_blankline_filetype = ['lua','go']
highlight IndentBlanklineChar guifg=#eee8d5 gui=nocombine
highlight IndentBlanklineContextChar guifg=#268bd2 gui=nocombine
]])

vim.cmd([[let g:indent_blankline_show_trailing_blankline_indent = v:false]])
require("indent_blankline").setup {
	-- for example, context is off by default, use this to turn it on
	-- show_current_context = true,
	-- show_current_context_start = true,
}
