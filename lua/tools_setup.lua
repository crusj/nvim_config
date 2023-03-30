-- terminal
require("toggleterm").setup{
	direction =  'float',
	open_mapping = [[\a]],
	float_opts = {
		border = 'curved',
        windblend = 3,
	},
    hide_numbers = false,
	shell = 'fish',
    auto_scroll = false,
    highlights = {
        FloatBorder = {
            guifg = "#8c2eb8",
        },
    }
}
