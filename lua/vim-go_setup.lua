vim.cmd([[
	let g:go_diagnostics_enabled = 0 
	let g:go_metalinter_command = 'golangci-lint'
	let g:go_metalinter_autosave =1 
]])
vim.cmd([[
	let g:go_metalinter_autosave_enabled = ['gofumpt','whitespace','stylecheck','structcheck','unused','errname','forcetypeassert','goconst','gocyclo','godox','ifshort','makezero','tagliatelle','unparam','wsl']
]])
