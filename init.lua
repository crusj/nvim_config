require('impatient')
require('options')
require('plugins')
require('complete')

require('telescope_setup')
require('session_manager_setup')
require('buffline_setup')
require('color_setup')
require('lualine_setup')
require('vim-go_setup')
require('treesitter_setup')
require('maps')
require('comment_setup')
require('hop_setup')
require('fidget_setup')
require('quickfix')
require('rest')
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
require('wiki_setup')
require('bank_line_setup')
require("test_setup")
require("color_picker_setup")
require('tree_setup')
require("climb_setup")
require("marks_setup")

require("git_conflict_setup")
require("gitsigns_setup")

require("smooth_setup")
require("scroll_setup")

require("minimap_setup")
require("mind_setup")
require("tabnine_setup")

require("tail")
