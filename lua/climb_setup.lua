local keyopts = { noremap = true, silent = true }
vim.keymap.set({'n', 'v', 'o'}, '<space>1', require('tree-climber').goto_next, keyopts)
vim.keymap.set({'n', 'v', 'o'}, '<space>2', require('tree-climber').goto_prev, keyopts)
vim.keymap.set('n', '<space>3', require('tree-climber').goto_parent, keyopts)
-- 选择整个Node
local function select_node() 
    vim.fn.execute("normal ^")
    require("tree-climber").select_node()
end

vim.keymap.set({'n', 'v'}, '<space>I', select_node, keyopts)
-- 选择单个node
vim.keymap.set({'n', 'v'}, '<space>i', require('tree-climber').select_node, keyopts)
