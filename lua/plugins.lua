-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  	use 'wbthomason/packer.nvim'
  	use 'neovim/nvim-lspconfig'
  	use 'hrsh7th/cmp-nvim-lsp'
  	use 'hrsh7th/cmp-buffer'
  	use 'hrsh7th/cmp-path'
  	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'ray-x/lsp_signature.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'onsails/lspkind-nvim'
	use 'kyazdani42/nvim-tree.lua'
	use 'kyazdani42/nvim-web-devicons'
	use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {'nvim-telescope/telescope-ui-select.nvim' }
	use 'Shatur/neovim-session-manager'
	use 'voldikss/vim-floaterm'
	use 'glepnir/dashboard-nvim'
	use 'vim-test/vim-test'
	use 'sebdah/vim-delve'
	use "rafamadriz/friendly-snippets"
	use 'windwp/nvim-autopairs'
  	use 'nvim-lualine/lualine.nvim'
	use 'simrat39/symbols-outline.nvim'
	use 'rakr/vim-one'
	use 'overcache/NeoSolarized'
	use 'hoschi/yode-nvim'
	use 'AndrewRadev/splitjoin.vim'
	use 'hexdigest/gounit-vim'
end)

