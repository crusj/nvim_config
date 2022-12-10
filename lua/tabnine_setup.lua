-- online
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  debounce_ms = 500,
  suggestion_color = {gui = "#808080", cterm = 244}
})

local tcf = require('cmp_tabnine.config')
tcf:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = '..',
	ignored_file_types = {
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	},
	show_prediction_strength = false
})
