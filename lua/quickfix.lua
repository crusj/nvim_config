-- golangcilint
vim.cmd([[

	let g:asyncrun_open = 8
	nmap <silent> gl <cmd>AsyncRun -strip golangci-lint run --issues-exit-code=0 --enable "gofumpt,nlreturn,whitespace,stylecheck,structcheck,unused,errname,forcetypeassert,goconst,gocyclo,godox,ifshort,makezero,tagliatelle,unparam,wsl,gomnd,errchkjson" "$(VIM_FILEPATH)"<cr>
]])
