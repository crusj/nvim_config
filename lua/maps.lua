-- map keys
local function map()
	local maps = {
		{"nmap","<F1>","<nop>"},
		{"imap","<F1>","<nop>"},
		{"nmap","<space>ft","<cmd>SymbolsOutline<cr>"},
		{"nmap","<silent> <space>j","<c-w>h"},
		{"nmap","<silent> <space>k","<c-w>l"},
		{"nmap","<silent> <leader>1","<cmd>DlvToggleBreakpoint<cr>"},
		{"nmap","<silent> <leader>2","<cmd>DlvDebug<cr>"},
		{"nmap","<silent> <leader>3","<cmd>DlvTest<cr>"},
		{"nmap","<silent> <leader>t","<cmd>TestNearest-v<cr>"},
		{"nmap","<silent> <leader>e","<cmd>b#<cr>"},
		{"nmap","<silent> gsf","<cmd>GoFillStruct<cr>"},
		{"nmap","<silent> gf","<cmd>GoFmt<cr>"},
		{"nmap","<silent> gft","<cmd>GoUnit<cr>"},
		{"nmap","<silent> <leader>hd","<cmd>lua vim.lsp.buf.hover()<cr>"},
		{"nmap","<silent> <leader>hs","<cmd>lua vim.lsp.buf.signature_help()<cr>"}
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

