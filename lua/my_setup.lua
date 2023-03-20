vim.keymap.set("n", "gT", ":lua require'my'.generate_go_tags()<CR>", { silent = true })
vim.keymap.set("n", "gM", ":lua require'my'.copy_last_git_msg()<CR>", { silent = true })
vim.keymap.set("n", "gO", ":lua require'my'.open_op()<CR>", { silent = true })
vim.keymap.set("n", "gR", ":lua require'my'.open_op(true)<CR>", { silent = true })
vim.keymap.set("n", "gv", ":lua require'bookmarks.float'.create_win({})<CR>", { silent = true })

-- buffer
vim.keymap.set("n", "bco", ":lua require'my'.close_others_buff()<CR>", { silent = true })
vim.keymap.set("n", "bcl", ":BufferLineCloseLeft<CR>", { silent = true })
vim.keymap.set("n", "bcr", ":BufferLineCloseRight<CR>", { silent = true })

--auto
require("my").add_import()
