-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  	use 'wbthomason/packer.nvim'

	-- view
	use 'kyazdani42/nvim-web-devicons'

	-- status
	use 'glepnir/dashboard-nvim'
	use 'Shatur/neovim-session-manager'
	use 'kyazdani42/nvim-tree.lua'
	use {'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons'}
  	use 'nvim-lualine/lualine.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'j-hui/fidget.nvim'

	-- complete
  	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
  	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
  	use 'hrsh7th/cmp-buffer'
  	use 'hrsh7th/cmp-path'
  	use 'hrsh7th/cmp-cmdline'
	use 'f3fora/cmp-spell'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'onsails/lspkind-nvim'
	use "rafamadriz/friendly-snippets"
	use 'simrat39/symbols-outline.nvim'
	use 'mfussenegger/nvim-lint'
	use 'ray-x/lsp_signature.nvim'

	-- search
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use {'nvim-telescope/telescope-ui-select.nvim' }
	use {'kevinhwang91/nvim-bqf'}
	use {'nvim-treesitter/nvim-treesitter',run = ':TSUpdate'}
	use {'junegunn/fzf', run = function()
    	vim.fn['fzf#install']()
		end
	}
	use { "tami5/sqlite.lua" }
	use 'nvim-telescope/telescope-frecency.nvim'

	-- tools
	use 'hoschi/yode-nvim'
	use 'voldikss/vim-floaterm'
	use 'itchyny/vim-cursorword'
	use 'windwp/nvim-autopairs'
	use 'AndrewRadev/splitjoin.vim'
	use 'tpope/vim-surround'
	use 'terrortylor/nvim-comment'
	use {
	  'phaazon/hop.nvim',
	  branch = 'v1', -- optional but strongly recommended
	  config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
	  end
	}
	use 'skywind3000/asyncrun.vim'
	use 'NTBBloodbath/rest.nvim'
	use 'lewis6991/impatient.nvim'
	use 'max397574/better-escape.nvim' 
	use 'windwp/nvim-spectre'
	use 'voldikss/vim-translator'
	use {"akinsho/toggleterm.nvim"}

	-- test and debug
	use 'vim-test/vim-test'
	use 'sebdah/vim-delve'
	use 'buoto/gotests-vim'

	-- colorscheme
	use 'rakr/vim-one'
	use 'overcache/NeoSolarized'
	use 'rebelot/kanagawa.nvim'
	use 'p00f/nvim-ts-rainbow'
	use 'glepnir/oceanic-material'
	use 'folke/tokyonight.nvim'

	-- git 
	use 'sindrets/diffview.nvim'
	use 'f-person/git-blame.nvim'
end)

