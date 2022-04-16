-- translate plugin
vim.cmd([[
	let g:translator_default_engines = ['google']
	nmap <silent> <Leader>w <Plug>TranslateW
	vmap <silent> <Leader>w <Plug>TranslateWV
]])

