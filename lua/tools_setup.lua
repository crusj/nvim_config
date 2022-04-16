-- translate plugin
vim.cmd([[
	let g:translator_default_engines = ['google']
	nmap <silent> <Leader>w <Plug>TranslateW
	vmap <silent> <Leader>w <Plug>TranslateWV
	let g:translator_proxy_url = 'socks5://127.0.0.1:1086'
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
