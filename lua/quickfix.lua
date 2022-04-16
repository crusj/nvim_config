-- golangcilint
vim.cmd([[
	let g:asyncrun_open = 8
	nmap <silent> gl <cmd>AsyncRun golangci-lint run  --fast --issues-exit-code=0 --enable-all  "$(VIM_FILEPATH)"<cr>
]])
