-- map keys
local function map()
	local maps = {
		{"nmap","<F1>","<nop>"},
		{"imap","<F1>","<nop>"},
		{"nmap","<space>ft","<cmd>SymbolsOutline<cr>"},
		{"nmap","<silent> <space>h","<c-w>h"},
		{"nmap","<silent> <space>l","<c-w>l"},
		{"nmap","<silent> <leader>1","<cmd>DlvToggleBreakpoint<cr>"},
		{"nmap","<silent> <leader>2","<cmd>DlvDebug<cr>"},
		{"nmap","<silent> <leader>3","<cmd>DlvTest<cr>"},
		{"nmap","<silent> <leader>t","<cmd>TestNearest-v<cr>"},
		{"nmap","<silent> <leader>e","<cmd>b#<cr>"},
		{"nmap","<silent> gsf","<cmd>GoFillStruct<cr>"},
		{"nmap","<silent> gf","<cmd>lua vim.lsp.buf.formatting()<cr>"},
		{"nmap","<silent> gt","<cmd>GoTests<cr>"},
		{"nmap","<silent> <space>fd","<cmd>lua vim.lsp.buf.hover()<CR>"},
		{"nmap","<silent> <space>fs","<cmd>lua vim.lsp.buf.signature_help()<CR>"},
		{"nmap","<silent> <leader>do","<cmd>DiffviewOpen<cr>"},
		{"nmap","<silent> <leader>dc","<cmd>DiffviewClose<cr>"},
		{"nmap","<silent> <leader>dh","<cmd>DiffviewFileHistory<cr>"},
	}

	for i,item in ipairs(maps) do
		local cmd = ""
		for j,piece in ipairs(item) do
			cmd = cmd .. " " .. piece 
		end
		vim.cmd(cmd)
	end
end
map()

