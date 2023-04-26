require('options')
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    -- wiki
    {
        'renerocksai/telekasten.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },

    -- dashboard
    {
        'mhinz/vim-startify',
        dependencies = {
            "ray-x/guihua.lua"
        }
    },

    -- 会话，session
    {
        'Shatur/neovim-session-manager',
        config = function()
            local Path = require('plenary.path')
            require('session_manager').setup({
                sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
                path_replacer = '__',                                        -- The character to which the path separator will be replaced for session files.
                colon_replacer = '++',                                       -- The character to which the colon symbol will be replaced for session files.
                autoload_mode = 'Disabled',                                  -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
                autosave_last_session = true,                                -- Automatically save last session on exit and on session switch.
                autosave_ignore_not_normal = true,                           -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
                autosave_ignore_filetypes = {                                -- All buffers of these file types will be closed before the session is saved.
                    'structure-go',
                    'gitcommit',
                    'NvimTree',
                    'hierarchy-tree-go',
                    'vimwiki'
                },
                autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
                max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
            })
            vim.keymap.set("n", "<space>s", "<cmd>SessionManager load_session<cr>", { silent = true })
        end
    },

    -- Neovim plugin to manage the file system and other tree like structures.
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        keys = { "<space>n" },
        dependencies = {
            "MunifTanjim/nui.nvim",
            's1n7ax/nvim-window-picker'
        },
        config = require("file_explore_config").fn
    },

    -- file explore
    {
        'kyazdani42/nvim-tree.lua',
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    },

    -- 文件面包屑,A snazzy bufferline for Neovim
    {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = function()
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
        end
    },

    -- A blazing fast and easy to configure Neovim statusline written in Lua.
    {
        'nvim-lualine/lualine.nvim',
        config = require("status_config").fn
    },

    -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
    {
        'j-hui/fidget.nvim',
        ft = { "go", "lua" },
        config = function()
            require("fidget").setup {}
        end,
        dependencies = {
            "neovim/nvim-lspconfig"
        }
    },

    -- Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
    {
        'RRethy/vim-illuminate',
        config = function()
            vim.cmd([[
                hi def IlluminatedWordText guibg=#CCFFFF
                hi def IlluminatedWordRead guibg=#CCFFFF
                hi def IlluminatedWordWrite guibg=#CCFFFF
            ]])

            -- default configuration
            require('illuminate').configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    -- 'lsp',
                    'treesitter',
                    -- 'regex',
                },
                -- delay: delay in milliseconds
                delay = 100,
                -- filetype_overrides: filetype specific overrides.
                -- The keys are strings to represent the filetype while the values are tables that
                -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
                filetype_overrides = {},
                -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                filetypes_denylist = {
                    'dirvish',
                    'fugitive',
                },
                -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
                filetypes_allowlist = {},
                -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
                -- See `:help mode()` for possible values
                modes_denylist = {},
                -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
                -- See `:help mode()` for possible values
                modes_allowlist = {},
                -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_denylist = {},
                -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_allowlist = {},
                -- under_cursor: whether or not to illuminate under the cursor
                under_cursor = false,
                -- large_file_cutoff: number of lines at which to use large_file_config
                -- The `under_cursor` option is disabled when this cutoff is hit
                large_file_cutoff = nil,
                -- large_file_config: config to use for large files (based on large_file_cutoff).
                -- Supports the same keys passed to .configure
                -- If nil, vim-illuminate will be disabled for large files.
                large_file_overrides = nil,
                -- min_count_to_highlight: minimum number of matches required to perform highlighting
                min_count_to_highlight = 1,
            })
        end
    },

    'neovim/nvim-lspconfig',
    -- 代码补全，complete
    {
        'hrsh7th/nvim-cmp',
        even         = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            {
                'hrsh7th/cmp-nvim-lua',
                ft = "lua",
            },

            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'f3fora/cmp-spell',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'onsails/lspkind-nvim',
            "rafamadriz/friendly-snippets",
            'mfussenegger/nvim-lint',
        },
        config       = function()
            require('complete')
        end
    },

    'ray-x/lsp_signature.nvim',


    -- search,telescope
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        config = require("telescope_config").fn,
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        }
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        config = function()
            require 'nvim-treesitter.configs'.setup {
                curl = { "--proxy", "http://127.0.0.1:7890" },
                -- One of "all", "maintained" (parsers with maintainers), or a list of languages
                -- ensure_installed = { "go", "lua", "gomod", "http", "json", "vim", "yaml", "bash" },

                -- Install languages synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- List of parsers to ignore installing
                ignore_install = { "javascript" },

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    -- list of language that will be disabled
                    disable = { "c", "org" },
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    -- additional_vim_regex_highlighting = { "" },
                    ensure_installed = {}
                },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = 1000,
                },
                indent = {
                    enable = false
                },
            }
        end,
        dependencies = {
            {
                'p00f/nvim-ts-rainbow',
            },
        },
        priority = 1000,
    },

    {
        'junegunn/fzf',
        build = function()
            vim.fn['fzf#install']()
        end
    },
    'nvim-telescope/telescope-frecency.nvim',

    -- Ai代码补全
    {
        "jackMort/ChatGPT.nvim",
        cmd = "ChatGPT",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("chatgpt").setup({
                keymaps = {
                    close = { "<C-c>" },
                    submit = "<Enter>",
                    yank_last = "<C-y>",
                    yank_last_code = "<C-k>",
                    scroll_up = "<C-u>",
                    scroll_down = "<C-d>",
                    toggle_settings = "<C-o>",
                    new_session = "<C-n>",
                    cycle_windows = "<Tab>",
                    -- in the Sessions pane
                    select_session = "<Space>",
                    rename_session = "r",
                    delete_session = "d",
                },
            })
        end
    },
    -- tools
    'windwp/nvim-autopairs',
    'xiyaowong/nvim-cursorword',
    'AndrewRadev/splitjoin.vim',
    'tpope/vim-surround',

    -- 注释, comment
    {
        'terrortylor/nvim-comment',
        keys = { "gcc" },
        config = function()
            require('nvim_comment').setup({ comment_empty = false })
        end
    },

    -- 全屏查找
    {
        'phaazon/hop.nvim',
        keys = { "fww", "fwl", "fwj", "fwk", "fll", "flk", "flj" },
        branch = 'v1', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop.highlight'.insert_highlights = function()
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
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
            require "helper".Maps({
                { "nmap", "<silent> fww", "<cmd>HopWord<cr>" },
                { "nmap", "<silent> fwl", "<cmd>HopWordCurrentLine<cr>" },
                { "nmap", "<silent> fwj", "<cmd>HopWordAC<cr>" },
                { "nmap", "<silent> fwk", "<cmd>HopWordBC<cr>" },
                { "nmap", "<silent> fll", "<cmd>HopLine<cr>" },
                { "nmap", "<silent> flk", "<cmd>HopLineBC<cr>" },
                { "nmap", "<silent> flj", "<cmd>HopLineAC<cr>" },
                { "nmap", "<silent> flm", "<cmd>HopLineMW<cr>" },
                { "nmap", "<silent> fcl", "<cmd>HopChar1CurrentLine<cr>" },
                { "nmap", "<silent> fcc", "<cmd>HopChar1<cr>" },
                { "nmap", "<silent> fcj", "<cmd>HopChar1AC<cr>" },
                { "nmap", "<silent> fck", "<cmd>HopChar1BC<cr>" },
                { "nmap", "<silent> fxl", "<cmd>HopChar2CurrentLine<cr>" },
                { "nmap", "<silent> fxx", "<cmd>HopChar2<cr>" },
                { "nmap", "<silent> fxj", "<cmd>HopChar2AC<cr>" },
                { "nmap", "<silent> fxk", "<cmd>HopChar2BC<cr>" },
            })
        end
    },

    'skywind3000/asyncrun.vim',

    -- http
    {
        'NTBBloodbath/rest.nvim',
        keys = { "\\rh" },
        config = function()
            require("rest-nvim").setup({
                -- Open request results in a horizontal split
                result_split_horizontal = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = false,
                -- Highlight request on run
                highlight = {
                    enabled = true,
                    timeout = 150,
                },
                result = {
                    -- toggle showing URL, HTTP info, headers at top the of result window
                    show_url = true,
                    show_http_info = true,
                    show_headers = true,
                },
                -- Jump to request line on run
                jump_to_request = false,
                env_file = '.env',
                custom_dynamic_variables = {},
                yank_dry_run = true,
            })

            vim.cmd([[nmap <silent> <leader>rh <Plug>RestNvim]])
        end
    },

    -- 搜索替换,seach,replace
    {
        'windwp/nvim-spectre',
        keys = { "<leader>sw" },
        config = function()
            vim.cmd([[
                nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
            ]])
        end
    },

    -- 终端
    {
        "akinsho/toggleterm.nvim",
        keys = { "\\a" },
        config = function()
            require("toggleterm").setup {
                direction = 'float',
                open_mapping = [[\a]],
                float_opts = {
                    border = 'curved',
                    windblend = 3,
                },
                hide_numbers = false,
                shell = 'fish',
                auto_scroll = false,
                highlights = {
                    FloatBorder = {
                        guifg = "#8c2eb8",
                    },
                }
            }
        end
    },

    -- 窗口ui
    {
        'ray-x/guihua.lua',
        build = 'cd lua/fzy && make',
        config = function()
            vim.cmd([[
                autocmd FileType go nnoremap <silent> \q :GoTermClose<cr>
            ]])
        end
    },

    'voldikss/vim-floaterm',

    -- golang结构预览
    {
        'crusj/structrue-go.nvim',
        ft = "go",
        branch = "main",
        config = require("structrue_config").fn
    },
    -- golang调用链
    {
        'crusj/hierarchy-tree-go.nvim',
        ft = "go",
        keys = { "\\ho", "\\hc" },
        dependencies = 'neovim/nvim-lspconfig',
        config = function()
            require("hierarchy-tree-go").setup({
                keymap = {
                    close = "\\hc",
                    open = "\\ho",
                }
            })
        end
    },
    -- golang
    {
        'edolphin-ydf/goimpl.nvim',
        ft = "go",
        keys = { "<leader>im" },
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-telescope/telescope.nvim' },
        },
        config = function()
            require 'telescope'.load_extension 'goimpl'
            vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
                { noremap = true, silent = true })
        end,
    },

    -- 书签工具，bookmarks
    {
        'crusj/bookmarks.nvim',
        keys = { "<space><space>" },
        config = function()
            require("bookmarks").setup({
                keymap = {
                    toggle = "<space><space>", -- toggle bookmarks
                    order = "o",               -- order bookmarks by frequency or updated_time
                },
                -- width = 0.9,
                height = 0.8,
                fix_enable = false,
                preview_ext_enable = false,
                border_style = "rounded",
                hl = {
                    border = "Normal",
                    cursorline = "guibg=Gray guifg=White", -- hl bookmarsk window cursorline
                }
            })
        end
    },


    'hrsh7th/cmp-nvim-lsp-signature-help',
    'rcarriga/nvim-notify',


    -- A more adventurous wildmenu
    {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder')
            wilder.setup({ modes = { ':', '/', '?' } })
            wilder.set_option('renderer', wilder.popupmenu_renderer(
                wilder.popupmenu_border_theme({
                    highlights = {
                        border = 'Normal', -- highlight to use for the border
                        -- selected_accent = wilder.make_hl('WilderPopupMenuSelectedAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f', background = 'none' } }),
                    },
                    -- 'single', 'double', 'rounded' or 'solid'
                    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
                    border = 'rounded',
                    left = { ' ', wilder.popupmenu_devicons() },
                    right = { ' ', wilder.popupmenu_scrollbar() },
                })
            ))
        end
    },

    -- 颜色选择器
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker")
        end,
    },



    -- 标记,mark
    {
        'chentoast/marks.nvim',
        config = function()
            require 'marks'.setup {
                -- whether to map keybinds or not. default true
                default_mappings = true,
                -- which builtin marks to show. default {}
                -- builtin_marks = { ".", "<", ">", "^"},
                -- whether movements cycle back to the beginning/end of buffer. default true
                cyclic = true,
                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = false,
                -- how often (in ms) to redraw signs/recompute mark positions.
                -- higher values will have better performance but may cause visual lag,
                -- while lower values may cause performance penalties. default 150.
                refresh_interval = 250,
                -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
                -- marks, and bookmarks.
                -- can be either a table with all/none of the keys, or a single number, in which case
                -- the priority applies to all marks.
                -- default 10.
                sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
                -- disables mark tracking for specific filetypes. default {}
                excluded_filetypes = { "bookmarks", "neo-tree", "neo-tree-popup", "structrue-go", "floaterm",
                    "toggleterm" },
                -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
                -- sign/virttext. Bookmarks can be used to group together positions and quickly move
                -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
                -- default virt_text is "".
                bookmark_0 = {
                    sign = "⚑",
                    virt_text = "hello world",
                    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
                    -- defaults to false.
                    annotate = false,
                },
                mappings = {}
            }
        end
    },

    -- a smooth scrolling neovim plugin written in lua.

    -- 滚动
    {
        'karb94/neoscroll.nvim',
        config = function()
            vim.cmd([[
                let g:scrollview_excluded_filetypes = [ 'nerdtree', 'neo-tree', 'bookmarks','structrue-go']
            ]])
        end
    },


    -- mini
    {
        'echasnovski/mini.nvim',
        branch = 'main',
        keys = { '<leader>ss' },
        config = function()
            vim.cmd([[
                highlight MiniMapNormal guifg=Green guibg=normal cterm=bold
                highlight MiniMapSymbolLine guifg=Green guibg=NONE cterm=bold
                highlight MiniMapSymbolView guifg=Green guibg=NONE cterm=bold
            ]])
            require("mini.map").setup -- No need to copy this inside `setup()`. Will be used automatically.
            {
                -- Highlight integrations (none by default)
                integrations = nil,

                -- Symbols used to display data
                symbols = {
                    -- Encode symbols. See `:h MiniMap.config` for specification and
                    -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
                    -- Default: solid blocks with 3x2 resolution.
                    encode = require("mini.map").gen_encode_symbols.dot('4x2'),
                    -- Scrollbar parts for view and line. Use empty string to disable any.
                    scroll_line = '⫸',
                    scroll_view = '┃',
                },

                -- Window options
                window = {
                    -- Whether window is focusable in normal way (with `wincmd` or mouse)
                    focusable = false,
                    -- Side to stick ('left' or 'right')
                    side = 'right',
                    -- Whether to show count of multiple integration highlights
                    show_integration_count = true,
                    -- Total width
                    width = 10,
                    -- Value of 'winblend' option
                    winblend = 25,
                },
            }

            vim.api.nvim_set_keymap("n", "<leader>ss", "<cmd>lua MiniMap.toggle()<cr>", { silent = true })
        end
    },

    -- 翻译
    {
        'JuanZoran/Trans.nvim',
        dependencies = 'kkharji/sqlite.lua',
        keys = { "\\tr" },
        config = require("translate_config").fn
    },


    -- 状态栏结构导航
    {
        'SmiteshP/nvim-gps'
    },

    -- 结构化移动
    {
        'drybalka/tree-climber.nvim',
        config = function()
            local keyopts = { noremap = true, silent = true }
            vim.keymap.set({ 'n', 'v', 'o' }, '<space>1', require('tree-climber').goto_next, keyopts)
            vim.keymap.set({ 'n', 'v', 'o' }, '<space>2', require('tree-climber').goto_prev, keyopts)
            vim.keymap.set('n', '<space>3', require('tree-climber').goto_parent, keyopts)

            -- 选择整个Node
            local function select_node()
                vim.fn.execute("normal ^")
                require("tree-climber").select_node()
            end

            vim.keymap.set({ 'n', 'v' }, '<space>I', select_node, keyopts)
            -- 选择单个node
            vim.keymap.set({ 'n', 'v' }, '<space>i', require('tree-climber').select_node, keyopts)
        end
    },

    -- test and debug
    {
        'buoto/gotests-vim',
        ft = "go",
        keys = { "gT" },
        dependencies = {
            {
                'vim-test/vim-test',
                config = function()
                    vim.cmd([[
                         let test#strategy = "floaterm"
                   ]])
                end
            },
        }
    },


    -- debug, dap
    {
        'leoluz/nvim-dap-go',
        ft = "go",
        keys = { "\\1", "\\2", "\\3", "\\4", "\\5", "\\6", "\\7", "\\8", "\\9", "\\0", "\\t" },
        dependencies = {
            'mfussenegger/nvim-dap',
            {
                'rcarriga/nvim-dap-ui',
                config = function()
                    require("dapui").setup({
                        mappings = {
                            expand = { "o", "<2-LeftMouse>" },
                            open = "<CR>",
                        },
                        layouts = {
                            {
                                elements = {
                                    -- Elements can be strings or table with id and size keys.
                                    { id = "scopes", size = 0.25 },
                                    "breakpoints",
                                    "watches",

                                },
                                size = 70, -- 40 columns
                                position = "left",
                            },
                        },
                        icons = {
                            collapsed = "",
                            current_frame = "",
                            expanded = ""
                        },
                    })
                end
            },
            'theHamsta/nvim-dap-virtual-text',

        },
        config = function()
            vim.cmd([[
                nnoremap <silent> \1 :lua require'dap'.toggle_breakpoint()<CR>
                nnoremap <silent> \2 :lua require'dap'.continue()<CR>
                nnoremap <silent> \3 :lua require'dap-go'.debug_test()<CR>
                nnoremap <silent> \4 :lua require'dap'.step_over()<CR>
                nnoremap <silent> \5 :lua require'dap'.step_into()<CR>
                nnoremap <silent> \6 :lua require'dap'.step_out()<CR>
                nnoremap <silent> \7 :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
                nnoremap <silent> \8 :lua require'dap'.run_to_cursor()<CR>
                nnoremap <silent> \9 :lua print(require'dap'.status())<CR>
                nnoremap <silent> \0 :lua require'dap'.disconnect()<CR>
                nnoremap <silent> \- :lua require'dap'.run_last()<CR>
                nnoremap <silent> \` :lua require'dapui'.toggle()<CR>
                nnoremap <silent> \. :lua require'dapui'.eval(nil, { enter = true})<CR>
            ]])

            vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'Breakpoint', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '->', texthl = 'DebugStop', linehl = '', numhl = '' })
        end
    },

    -- 主题颜色,colorschema
    {
        "EdenEast/nightfox.nvim",
        config = function()
            -- Default options
            require('nightfox').setup({
                options = {
                    -- Compiled file's destination location
                    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
                    compile_file_suffix = "_compiled", -- Compiled file suffix
                    transparent = false,               -- Disable setting background
                    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
                    dim_inactive = false,              -- Non focused panes set to alternative background
                    module_default = true,             -- Default enable value for modules
                    colorblind = {
                        enable = false,                -- Enable colorblind support
                        simulate_only = false,         -- Only show simulated colorblind colors and not diff shifted
                        severity = {
                            protan = 0,                -- Severity [0,1] for protan (red)
                            deutan = 0,                -- Severity [0,1] for deutan (green)
                            tritan = 0,                -- Severity [0,1] for tritan (blue)
                        },
                    },
                    styles = {
                        -- Style to be applied to different syntax groups
                        comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
                        conditionals = "NONE",
                        constants = "NONE",
                        functions = "italic",
                        keywords = "NONE",
                        numbers = "NONE",
                        operators = "NONE",
                        strings = "NONE",
                        types = "NONE",
                        variables = "NONE",
                    },
                    inverse = {
                        -- Inverse highlight for different types
                        match_paren = false,
                        visual = false,
                        search = false,
                    },
                    modules = { -- List of various plugins and additional options
                        -- ...
                    },
                },
                palettes = {},
                specs = {},
                groups = {},
            })

            vim.cmd([[colorscheme duskfox]])
        end
    },

    -- codeium
    {
        "jcdickinson/http.nvim",
        build = "cargo build --workspace --release"
    },
    -- ai代码补全,copilot
    {
        'github/copilot.vim',
        config = function()
            vim.cmd([[
                imap <silent><script><expr> <A-k> copilot#Accept("\<CR>")
                let g:copilot_no_tab_map = v:true
                let g:copilot_proxy = 'http://127.0.0.1:7890'
            ]])
        end
    },

    {
        "jcdickinson/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
    },

    -- 代码仓库管理,git
    {
        'sindrets/diffview.nvim',
        enabled = function()
            -- 是否存在.git目录
            return require("helper").DirectoryExists(".git")
        end,
        config = require("git_config").Diffview
    },

    {
        'akinsho/git-conflict.nvim',
        tag = "*",
        enabled = function()
            -- 是否存在.git目录
            return require("helper").DirectoryExists(".git")
        end,
        config = require("git_config").Conflict
    },

    {
        'lewis6991/gitsigns.nvim',
        enabled = function()
            -- 是否存在.git目录
            return require("helper").DirectoryExists(".git")
        end,
        config = require("git_config").GitSigns
    },

    -- indent
    {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v2.20.4",
        ft = { "lua", "go", "php" },
        config = function()
            vim.cmd([[
                let g:indent_blankline_char_blankline = '│'
                let g:indent_blankline_char = '│'
                let g:indent_blankline_use_treesitter = v:true
                let g:indent_blankline_indent_level = 4
                let g:indent_blankline_filetype = ['lua','go']
                let g:indent_blankline_show_trailing_blankline_indent = v:false
                highlight! IndentBlanklineContextChar  gui=nocombine
                highlight! IndentBlanklineContextStart guisp=#00FF00 gui=bold
                let g:indent_blankline_context_patterns = ['class', '^func', 'method', '^if', 'while', 'for', 'with', 'try', 'except', 'match', 'arguments', 'argument_list', 'object', 'dictionary', 'element', 'table', 'tuple', 'do_block', "type", "import", "return", "literal_value"]
             ]])

            require("indent_blankline").setup {
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
        priority = 999
    },

    -- 查看符号相关信息,glance
    {
        "dnlhc/glance.nvim",
        keys = { "gR" },
        config = function()
            local glance = require("glance")
            local actions = glance.actions
            glance.setup({
                height = 30, -- Height of the window
                zindex = 45,
                -- By default glance will open preview "embedded" within your active window
                -- when `detached` is enabled, glance will render above all existing windows
                -- and won't be restiricted by the width of your active window
                -- detached = true,

                -- Or use a function to enable `detached` only when the active window is too small
                -- (default behavior)
                detached = function(winid)
                    return vim.api.nvim_win_get_width(winid) < 100
                end,
                preview_win_opts = {
                    -- Configure preview window options
                    cursorline = true,
                    number = true,
                    wrap = true,
                },
                border = {
                    enable = true, -- Show window borders. Only horizontal borders allowed
                    top_char = '▀',
                    bottom_char = '▄',
                },
                list = {
                    position = 'right', -- Position of the list window 'left'|'right'
                    width = 0.33,       -- 33% width relative to the active window, min 0.1, max 0.5
                },
                theme = {
                    -- This feature might not work properly in nvim-0.7.2
                    enable = true, -- Will generate colors for the plugin based on your current colorscheme
                    mode = 'auto', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
                },
                mappings = {
                    list = {
                        ['j'] = actions.next,     -- Bring the cursor to the next item in the list
                        ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
                        ['<Down>'] = actions.next,
                        ['<Up>'] = actions.previous,
                        ['<Tab>'] = actions.next_location,       -- Bring the cursor to the next location skipping groups in the list
                        ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
                        ['<C-u>'] = actions.preview_scroll_win(5),
                        ['<C-d>'] = actions.preview_scroll_win(-5),
                        ['v'] = actions.jump_vsplit,
                        ['s'] = actions.jump_split,
                        ['t'] = actions.jump_tab,
                        ['<CR>'] = actions.jump,
                        ['o'] = actions.jump,
                        ['<space>'] = actions.enter_win('preview'), -- Focus preview window
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                        -- ['<Esc>'] = false -- disable a mapping
                    },
                    preview = {
                        ['Q'] = actions.close,
                        ['<Tab>'] = actions.next_location,
                        ['<S-Tab>'] = actions.previous_location,
                        ['<space>'] = actions.enter_win('list'), -- Focus list window
                    },
                },
                hooks = {},
                folds = {
                    fold_closed = '',
                    fold_open = '',
                    folded = true, -- Automatically fold list on startup
                },
                indent_lines = {
                    enable = true,
                    icon = '│',
                },
                winbar = {
                    enable = true, -- Available strating from nvim-0.8+
                },
            })

            vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
            vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
            vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
            vim.keymap.set('n', 'gI', '<CMD>Glance implementations<CR>')

            vim.cmd([[
                hi GlanceWinBarTitle guibg=#8e2668 guifg=white gui=bold,italic
                hi GlanceWinBarFilename guibg=#8e2668 guifg=white gui=bold
                hi GlanceWinBarFilepath guibg=#8e2668 guifg=white gui=bold
                hi GlanceBorderTop guibg=#7fd44c
            ]])
        end,
    },

    -- wiki
    {
        "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/Sync/wiki',
                }
            }
            vim.cmd([[
                set nocompatible
                filetype plugin on
                syntax on
            ]])
        end
    }
})


require('maps')
require('my_setup')


vim.cmd([[
  set guifont=SimSun:h9:cANSI:CHINESE_CHARSET
]])
