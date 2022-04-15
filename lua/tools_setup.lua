-- translate plugin
vim.cmd([[
	let g:translator_default_engines = ['google']
	let g:translator_proxy_url = 'socks5://127.0.0.1:1086'
	nmap <silent> <Leader>w <Plug>TranslateW
	vmap <silent> <Leader>w <Plug>TranslateWV
]])

