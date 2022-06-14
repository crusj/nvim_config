require 'hop.highlight'.insert_highlights = function ()
	  -- Highlight used for the mono-sequence keys (i.e. sequence of 1).
  vim.api.nvim_command('highlight default HopNextKey  guifg=red gui=bold ctermfg=198 cterm=bold')

  -- Highlight used for the first key in a sequence.
  vim.api.nvim_command('highlight default HopNextKey1 guifg=#CC0066 gui=bold ctermfg=45 cterm=bold')

  -- Highlight used for the second and remaining keys in a sequence.
  vim.api.nvim_command('highlight default HopNextKey2 guifg=#CC0066 ctermfg=45 gui=bold')

  -- Highlight used for the unmatched part of the buffer.
  -- ctermbg=bg is omitted because it errors if Normal does not have ctermbg set
  -- Luckily guibg=bg does not seem to error even if Normal does not have guibg set so it can be used
  vim.api.nvim_command('highlight default HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242')

  -- Highlight used for the fake cursor visible when hopping.
  vim.api.nvim_command('highlight default link HopCursor Cursor')
end

require 'hop'.setup()
