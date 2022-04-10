require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = valuelayout_config = {
	-- }
	dynamic_preview_title = true
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  builtin = {
	tags = {
		only_sort_tags = true,
		ignore_filename = false
	},
	lsp_references = {
		ignore_filename = false
	}
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
	fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
	["ui-select"] = {
		 require("telescope.themes").get_dropdown {
      	 }
	}

  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("ui-select")

vim.cmd([[
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
]])
vim.cmd([[
nnoremap <leader>fs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
]])
vim.cmd([[
nnoremap <leader>fd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
]])
vim.cmd([[
nnoremap <leader>fp <cmd>lua require('telescope.builtin').treesitter()<cr>
]])
vim.cmd([[
nnoremap <leader>ft <cmd>lua require('telescope.builtin').tags()<cr>
]])
vim.cmd([[
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
]])
vim.cmd([[
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
]])
vim.cmd([[
nnoremap <leader>fR <cmd>lua vim.lsp.buf.formatting()<cr>
]])
vim.cmd([[
nnoremap <leader>fi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
]])
vim.cmd([[
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
]])
vim.cmd([[
nnoremap <leader>fa <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
]])
