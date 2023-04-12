require("bookmarks").setup({
	keymap = {
		toggle = "<space><space>", -- toggle bookmarks
		order = "o", -- order bookmarks by frequency or updated_time
	},
	width = 0.9,
    height = 0.8,
    fix_enable = false,
    preview_ext_enable = false,
    border_style = "rounded",
    hl = {
        border="Normal",
        cursorline = "guibg=Gray guifg=White", -- hl bookmarsk window cursorline
    }
})
