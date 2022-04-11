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
		{"nmap","<silent> <leader>fl","<cmd>Telescope frecency<cr>"},

		-- move

		{"nmap","<silent> <tab>ww","<cmd>HopWord<cr>"},
		{"nmap","<silent> <tab>wl","<cmd>HopWordCurrentLine<cr>"},
		{"nmap","<silent> <tab>wa","<cmd>HopWordAC<cr>"},
		{"nmap","<silent> <tab>wb","<cmd>HopWordBC<cr>"},

		{"nmap","<silent> <tab>ll","<cmd>HopLine<cr>"},
		{"nmap","<silent> <tab>lb","<cmd>HopLineBC<cr>"},
		{"nmap","<silent> <tab>la","<cmd>HopLineAC<cr>"},
		{"nmap","<silent> <tab>lm","<cmd>HopLineMW<cr>"},

		{"nmap","<silent> <tab>1l","<cmd>HopChar1CurrentLine<cr>"},
		{"nmap","<silent> <tab>2l","<cmd>HopChar2CurrentLine<cr>"},
		{"nmap","<silent> <tab>11","<cmd>HopChar1<cr>"},
		{"nmap","<silent> <tab>1a","<cmd>HopChar1AC<cr>"},

		{"nmap","<silent> <tab>22","<cmd>HopChar2<cr>"},
		{"nmap","<silent> <tab>2b","<cmd>HopChar2BC<cr>"},
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

