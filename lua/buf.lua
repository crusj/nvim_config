require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "both",
    --- @deprecated, please specify numbers as a function to customize the styling
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 14,
    diagnostics = false,
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    color_icons = true , -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    sort_by = "insert_after_current"
  }
}

function CloseBuffer()
  local bufferline = require('bufferline')
  local bufferToDelete = vim.api.nvim_get_current_buf()
  local listedBuf = 0
  for k,buf in pairs(vim.api.nvim_list_bufs()) do
	 local ft = vim.api.nvim_buf_get_option(buf,'filetype')
	 if ft ~= 'NvimTree' and ft ~= 'tagbar' then
		 listedBuf = listedBuf + 1
	 end
  end

  if listedBuf > 1 then 
	  bufferline.cycle(-1)
  end

  vim.cmd('bdelete ' .. bufferToDelete)
end

vim.cmd([[nnoremap <silent> \x <cmd> lua CloseBuffer()<cr>]])
vim.cmd([[nnoremap <silent><space>k <cmd>BufferLineCycleNext<CR>]])
vim.cmd([[nnoremap <silent><space>j :BufferLineCyclePrev<CR>]])
vim.cmd([[nnoremap <silent>be :BufferLineSortByExtension<CR>]])
vim.cmd([[nnoremap <silent>bd :BufferLineSortByDirectory<CR>]])
vim.cmd([[nnoremap <silent><space>1 <Cmd>BufferLineGoToBuffer 1<CR>]])
vim.cmd([[nnoremap <silent><space>2 <Cmd>BufferLineGoToBuffer 2<CR>]])
vim.cmd([[nnoremap <silent><space>3 <Cmd>BufferLineGoToBuffer 3<CR>]])
vim.cmd([[nnoremap <silent><space>4 <Cmd>BufferLineGoToBuffer 4<CR>]])
vim.cmd([[nnoremap <silent><space>5 <Cmd>BufferLineGoToBuffer 5<CR>]])
vim.cmd([[nnoremap <silent><space>6 <Cmd>BufferLineGoToBuffer 6<CR>]])
vim.cmd([[nnoremap <silent><space>7 <Cmd>BufferLineGoToBuffer 7<CR>]])
vim.cmd([[nnoremap <silent><space>8 <Cmd>BufferLineGoToBuffer 8<CR>]])
vim.cmd([[nnoremap <silent><space>9 <Cmd>BufferLineGoToBuffer 9<CR>]])
