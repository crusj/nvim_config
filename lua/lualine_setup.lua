local lualine = require("lualine")
lualine.setup({
	options = {
		theme = 'tokyonight',
		component_separators = { left = '', right = ''},
		disabled_filetypes = {'Outline','NvimTree','dashboard'},
		section_separators = { left = '', right = ''},
	},
	sections = {
		lualine_a = {
			{
				'mode',
				padding = 1, 

			}
		},
		lualine_c = {
			{
				'filename',
				path = 2,
			}
		}
	},
	extensions = {
	}
})
