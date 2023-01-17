vim.cmd([[
let g:indent_blankline_char_blankline = '│'
let g:indent_blankline_char = '│'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_indent_level = 4
let g:indent_blankline_filetype = ['lua','go']
let g:indent_blankline_show_trailing_blankline_indent = v:false

highlight IndentBlanklineChar guifg=#FFBDA9 gui=nocombine
highlight IndentBlanklineContextChar guifg=#FF6678 gui=nocombine
highlight IndentBlanklineContextStart guisp=#00FF00 gui=bold

]])

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
