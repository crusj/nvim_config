require('impatient')
require('options')
require('plugins')
require('complete')

require('nvim_tree_setup')
require('telescope_setup')
require('session_manager_setup')
require('buffline_setup')
require('color_setup')
require('lualine_setup')
require('vim-go_setup')
require('treesitter_setup')
require('maps')
require('outline_setup')
require('yode_setup')
require('comment_setup')
require('hop_setup')
require('fidget_setup')
require('quickfix')
require('rest')
require("blame_setup")
require("search_setup")
require("tools_setup")
require("gps_setup")
require('guihua_setup')
require('my_setup')
require('dap_setup')

require("strutrue_go_setup")
require("bookmarks_setup")
require("hierarchy-tree-go").setup({
	keymap = {
		close = "\\hc" ,
		open = "\\ho" ,
	}
})
require('wilder_setup')
require('org_setup')
require('wiki_setup')
require('bank_line_setup')
require("test_setup")
require("db_setup")
require("color_picker_setup")


