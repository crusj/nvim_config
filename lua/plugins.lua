-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- lua `fork` of vim-web-devicons for neovim
    use 'kyazdani42/nvim-web-devicons'
    -- complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
    use 'nvim-lua/plenary.nvim'
    use 'mhinz/vim-startify'
    use 'Shatur/neovim-session-manager'

    -- Neovim plugin to manage the file system and other tree like structures.
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "MunifTanjim/nui.nvim",
            's1n7ax/nvim-window-picker'
        }
    }
    use {
        'kyazdani42/nvim-tree.lua',
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- A snazzy bufferline for Neovim
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons' }
    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    use {
        'nvim-lualine/lualine.nvim',
    }

    -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
    use 'j-hui/fidget.nvim'

    -- complete
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'f3fora/cmp-spell'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'onsails/lspkind-nvim'
    use "rafamadriz/friendly-snippets"
    use 'mfussenegger/nvim-lint'
    use 'ray-x/lsp_signature.nvim'
    use 'ray-x/go.nvim'
    -- use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }

    -- search
    use 'nvim-telescope/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'junegunn/fzf', run = function()
        vim.fn['fzf#install']()
    end
    }
    use { "tami5/sqlite.lua" }
    use 'nvim-telescope/telescope-frecency.nvim'

    -- tools
    use 'windwp/nvim-autopairs'
    use 'xiyaowong/nvim-cursorword'
    use 'AndrewRadev/splitjoin.vim'
    use 'tpope/vim-surround'
    use 'terrortylor/nvim-comment'
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use 'skywind3000/asyncrun.vim'
    use 'NTBBloodbath/rest.nvim'
    use 'lewis6991/impatient.nvim'
    use {
        'ggandor/lightspeed.nvim',
        requires = "tpope/vim-repeat",

    } -- Lightspeed is a motion plugin for Neovim.

    --  A search panel for neovim.
    use 'windwp/nvim-spectre'
    use 'voldikss/vim-translator'
    use { "akinsho/toggleterm.nvim" }
    use {
        'ray-x/guihua.lua',
        run = 'cd lua/fzy && make'
    }

    use {
        'crusj/structrue-go.nvim',
        branch = "main"
    }
    use 'crusj/bookmarks.nvim'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'rcarriga/nvim-notify'
    use {
        'crusj/hierarchy-tree-go.nvim',
        requires = 'neovim/nvim-lspconfig'
    }
    -- A more adventurous wildmenu
    use 'gelguy/wilder.nvim'
    use "lukas-reineke/indent-blankline.nvim"
    use({ "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    })
    use 'chentoast/marks.nvim'

    -- treesitter
    use 'SmiteshP/nvim-gps'
    use 'p00f/nvim-ts-rainbow'
    use 'drybalka/tree-climber.nvim'

    -- test and debug
    use 'vim-test/vim-test'
    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'

    -- colorscheme
    use 'overcache/NeoSolarized'
    use 'ishan9299/nvim-solarized-lua'


    -- git
    use 'sindrets/diffview.nvim'
    use { 'akinsho/git-conflict.nvim', tag = "*" }
    use 'lewis6991/gitsigns.nvim'
end)
