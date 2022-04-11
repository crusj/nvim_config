-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  	use 'wbthomason/packer.nvim'

	-- icon
	use 'kyazdani42/nvim-web-devicons'

	-- status
	use 'glepnir/dashboard-nvim'
	use 'Shatur/neovim-session-manager'
	use 'kyazdani42/nvim-tree.lua'
	use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
  	use 'nvim-lualine/lualine.nvim'
	use 'nvim-lua/plenary.nvim'

	-- complete
  	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
  	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
  	use 'hrsh7th/cmp-buffer'
  	use 'hrsh7th/cmp-path'
  	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'ray-x/lsp_signature.nvim'
	use 'onsails/lspkind-nvim'
	use "rafamadriz/friendly-snippets"
	use 'simrat39/symbols-outline.nvim'

	-- search
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {'nvim-telescope/telescope-ui-select.nvim' }
	use 'nvim-treesitter/nvim-treesitter'

	-- tools
	use 'hoschi/yode-nvim'
	use 'voldikss/vim-floaterm'
	use 'itchyny/vim-cursorword'
	use 'windwp/nvim-autopairs'
	use 'AndrewRadev/splitjoin.vim'

	-- test and debug
	use 'vim-test/vim-test'
	use 'sebdah/vim-delve'
	use 'buoto/gotests-vim'

	-- colorscheme
	use 'rakr/vim-one'
	use 'overcache/NeoSolarized'


	-- git 
	use 'sindrets/diffview.nvim'
end)

