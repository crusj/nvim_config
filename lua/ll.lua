require('lualine').setup({
	options = {
		theme = 'solarized_light',
		disabled_filetypes = {'Outline','NvimTree','dashboard'},
	},
	sections = {
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

