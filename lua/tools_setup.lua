-- translate plugin
vim.cmd([[
	let g:translator_default_engines = ['youdao']
	nmap <silent> <Leader>w <Plug>TranslateW
	vmap <silent> <Leader>w <Plug>TranslateWV
]])


-- terminal
require("toggleterm").setup{
	direction =  'float',
	open_mapping = [[\a]],
	float_opts = {
		border = 'double',
	},
	shell = 'fish'
}
