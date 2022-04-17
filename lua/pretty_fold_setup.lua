require('pretty-fold').setup {
	comment_signs = {
    	{ '//'}, -- multiline comment
	}
}
require('pretty-fold.preview').setup({
  key = 'h'
})
