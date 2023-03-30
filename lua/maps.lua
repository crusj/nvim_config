-- map keys
local function map()
    local maps = {
        { "nmap",     "<F1>",                      "<nop>" },
        { "imap",     "<F1>",                      "<nop>" },
        { "nmap",     "<space>ft",                 "<cmd>Vista!!<cr>" },
        { "nmap",     "<silent> <space>h",         "<c-w>h" },
        { "nmap",     "<silent> <space>l",         "<c-w>l" },
        { "nmap",     "<silent> <leader>t",        "<cmd>TestNearest -v -count=1<cr>" },
        { "nmap",     "<silent> <leader>e",        "<cmd>b#<cr>" },
        { "nmap",     "<silent> gff",              "<cmd>lua vim.lsp.buf.format({async = true})<cr>" },
        { "nmap",     "<silent> gt",               "<cmd>GoTests<cr>" },
        { "nmap",     "<silent> <space>fd",        "<cmd>lua vim.lsp.buf.hover()<CR>" },
        { "nmap",     "<silent> gfd",              "<cmd>lua vim.lsp.buf.hover()<CR>" },
        { "nmap",     "<silent> <space>fs",        "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
        { "nmap",     "<silent> gr",               "<cmd>lua vim.lsp.buf.rename()<cr>" },
        { "nmap",     "<silent> <leader>do",       "<cmd>DiffviewOpen<cr>" },
        { "nmap",     "<silent> <leader>d1",       "<cmd>DiffviewOpen HEAD~1<cr>" },
        { "nmap",     "<silent> <leader>dc",       "<cmd>DiffviewClose<cr>" },
        { "nmap",     "<silent> <leader>dh",       "<cmd>DiffviewFileHistory<cr>" },
        { "nmap",     "<silent> <leader><leader>", "<cmd>Telescope frecency<cr>" },
        { "nmap",     "<silent> <leader>pc",        "<cmd>PickColor<cr>" },


        -- move
        { "nmap",     "<silent> fww",              "<cmd>HopWord<cr>" },
        { "nmap",     "<silent> fwl",              "<cmd>HopWordCurrentLine<cr>" },
        { "nmap",     "<silent> fwj",              "<cmd>HopWordAC<cr>" },
        { "nmap",     "<silent> fwk",              "<cmd>HopWordBC<cr>" },
        { "nmap",     "<silent> fll",              "<cmd>HopLine<cr>" },
        { "nmap",     "<silent> flk",              "<cmd>HopLineBC<cr>" },
        { "nmap",     "<silent> flj",              "<cmd>HopLineAC<cr>" },
        { "nmap",     "<silent> flm",              "<cmd>HopLineMW<cr>" },
        { "nmap",     "<silent> \\ds",             "<cmd>LuaSnipUnlinkCurrent<cr>" },
        { "nmap",     "<silent> fcl",              "<cmd>HopChar1CurrentLine<cr>" },
        { "nmap",     "<silent> fcc",              "<cmd>HopChar1<cr>" },
        { "nmap",     "<silent> fcj",              "<cmd>HopChar1AC<cr>" },
        { "nmap",     "<silent> fck",              "<cmd>HopChar1BC<cr>" },
        { "nmap",     "<silent> fxl",              "<cmd>HopChar2CurrentLine<cr>" },
        { "nmap",     "<silent> fxx",              "<cmd>HopChar2<cr>" },
        { "nmap",     "<silent> fxj",              "<cmd>HopChar2AC<cr>" },
        { "nmap",     "<silent> fxk",              "<cmd>HopChar2BC<cr>" },


        -- operator movement
        { "onoremap", "p i(" },
        { "onoremap", "b i{" },
        { "onoremap", "m i[" },
        { "onoremap", "np",                        ":<c-u>normal! f(vi(<cr>" },

        -- chatgpt
        { "vnoremap", "<silent> <leader>op",       "<cmd>'<,'>ChatGPTRun optimize_code <cr>" },
        { "nmap",     "<silent> <leader>ch",       "<cmd>ChatGPT<cr>" }
    }

    for _, item in ipairs(maps) do
        local cmd = ""
        for _, piece in ipairs(item) do
            cmd = cmd .. " " .. piece
        end
        vim.cmd(cmd)
    end
end
map()
