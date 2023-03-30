vim.cmd([[
let g:indent_blankline_char_blankline = '│'
let g:indent_blankline_char = '│'
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_indent_level = 4
let g:indent_blankline_filetype = ['lua','go']
let g:indent_blankline_show_trailing_blankline_indent = v:false
highlight IndentBlanklineContextChar  gui=nocombine
highlight IndentBlanklineContextStart guisp=#00FF00 gui=bold
let g:indent_blankline_context_patterns = ['class', '^func', 'method', '^if', 'while', 'for', 'with', 'try', 'except', 'match', 'arguments', 'argument_list', 'object', 'dictionary', 'element', 'table', 'tuple', 'do_block', "type", "import", "return", "literal_value"]
]])

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
