require('bufferline').setup {}

function CloseBuffer()
    local bufferline = require('bufferline')
    local bufferToDelete = vim.api.nvim_get_current_buf()
    local listedBuf = 0
    for k, buf in pairs(vim.api.nvim_list_bufs()) do
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if ft ~= 'NvimTree' and ft ~= 'tagbar' then
            listedBuf = listedBuf + 1
        end
    end

    if listedBuf > 1 then
        bufferline.cycle(-1)
    end

    vim.cmd('bdelete! ' .. bufferToDelete)
end

-- buffer
vim.cmd([[
nnoremap <silent> \x <cmd> lua CloseBuffer()<cr>
nnoremap <silent><space>k <cmd>BufferLineCycleNext<CR>
nnoremap <silent><space>j :BufferLineCyclePrev<CR>
]])

-- tab
vim.cmd([[
nnoremap <silent><space><Left> <cmd>tabnext<CR>
nnoremap <silent><space><Right> <cmd>tabprevious<CR>
]])

-- sort
vim.cmd([[
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent>bp :BufferLinePick<CR>
]])
