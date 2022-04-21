local lualine = require("lualine")
local gps = require("nvim-gps")
lualine.setup({
	options = {
		theme = 'solarized_light',
		component_separators = { left = '', right = '' },
		disabled_filetypes = {},
		section_separators = { left = '', right = '' },
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
			},
			{
				gps.get_location,
				cond = gps.is_available 
			},
		}
	},
	extensions = {
	}
})
