local lualine = require("lualine")
lualine.setup({
	options = {
		theme = 'tokyonight',
		disabled_filetypes = {'Outline','NvimTree','dashboard'},
	},
	sections = {
		lualine_a = {
			{
				'mode',
				padding = 1 

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
