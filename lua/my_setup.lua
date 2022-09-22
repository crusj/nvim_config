vim.keymap.set("n", "gT", ":lua require'my'.generate_go_tags()<CR>", { silent = true })
vim.keymap.set("n", "gM", ":lua require'my'.copy_last_git_msg()<CR>", { silent = true })
vim.keymap.set("n", "gv", ":lua require'bookmarks.float'.create_win({})<CR>", { silent = true })
