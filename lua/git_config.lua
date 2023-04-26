-- Lua
local M = {}


function M.Diffview()
    local cb = require 'diffview.config'.diffview_callback
    require 'diffview'.setup {
        diff_binaries = false,    -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        use_icons = true,         -- Requires nvim-web-devicons
        icons = {
            -- Only applies when use_icons is true.
            folder_closed = "",
            folder_open = "",
        },
        signs = {
            fold_closed = "",
            fold_open = "",
        },
        file_panel = {
            win_config = {
                position = "left",  -- One of 'left', 'right', 'top', 'bottom'
                width = 35,         -- Only applies when position is 'left' or 'right'
                height = 10,        -- Only applies when position is 'top' or 'bottom'
            },
            listing_style = "tree", -- One of 'list' or 'tree'
            tree_options = {
                -- Only applies when listing_style is 'tree'
                flatten_dirs = true,             -- Flatten dirs that only contain one single dir
                folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
            },
        },
        file_history_panel = {
            win_config = {
                position = "bottom",
                width = 35,
                height = 16,
            },
            log_options = {
                git = {
                    single_file = {
                        max_count = 256,   -- Limit the number of commits
                        follow = false,    -- Follow renames (only for single file)
                        all = false,       -- Include all refs under 'refs/' including HEAD
                        merges = false,    -- List only merge commits
                        no_merges = false, -- List no merge commits
                        reverse = false,   -- List commits in reverse order
                    }
                }
            },
        },
        default_args = {
            -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        hooks = {},                   -- See ':h diffview-config-hooks'
        key_bindings = {
            disable_defaults = false, -- Disable the default key bindings
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            view = {
                ["<tab>"]      = cb("select_next_entry"), -- Open the diff for the next file
                ["<s-tab>"]    = cb("select_prev_entry"), -- Open the diff for the previous file
                ["gf"]         = cb("goto_file"),         -- Open the file in a new split in previous tabpage
                ["<C-w><C-f>"] = cb("goto_file_split"),   -- Open the file in a new split
                ["<C-w>gf"]    = cb("goto_file_tab"),     -- Open the file in a new tabpage
                ["<leader>e"]  = cb("focus_files"),       -- Bring focus to the files panel
                ["<leader>b"]  = cb("toggle_files"),      -- Toggle the files panel.
            },
            file_panel = {
                ["j"]             = cb("next_entry"),   -- Bring the cursor to the next file entry
                ["<down>"]        = cb("next_entry"),
                ["k"]             = cb("prev_entry"),   -- Bring the cursor to the previous file entry.
                ["<up>"]          = cb("prev_entry"),
                ["<cr>"]          = cb("select_entry"), -- Open the diff for the selected entry.
                ["o"]             = cb("select_entry"),
                ["<2-LeftMouse>"] = cb("select_entry"),
                ["-"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
                ["S"]             = cb("stage_all"),          -- Stage all entries.
                ["U"]             = cb("unstage_all"),        -- Unstage all entries.
                ["X"]             = cb("restore_entry"),      -- Restore entry to the state on the left side.
                ["R"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
                ["<tab>"]         = cb("select_next_entry"),
                ["<s-tab>"]       = cb("select_prev_entry"),
                ["gf"]            = cb("goto_file"),
                ["<C-w><C-f>"]    = cb("goto_file_split"),
                ["<C-w>gf"]       = cb("goto_file_tab"),
                ["i"]             = cb("listing_style"),       -- Toggle between 'list' and 'tree' views
                ["f"]             = cb("toggle_flatten_dirs"), -- Flatten empty subdirectories in tree listing style.
                ["<leader>e"]     = cb("focus_files"),
                ["<leader>b"]     = cb("toggle_files"),
            },
            file_history_panel = {
                ["g!"]            = cb("options"),          -- Open the option panel
                ["<C-A-d>"]       = cb("open_in_diffview"), -- Open the entry under the cursor in a diffview
                ["y"]             = cb("copy_hash"),        -- Copy the commit hash of the entry under the cursor
                ["zR"]            = cb("open_all_folds"),
                ["zM"]            = cb("close_all_folds"),
                ["j"]             = cb("next_entry"),
                ["<down>"]        = cb("next_entry"),
                ["k"]             = cb("prev_entry"),
                ["<up>"]          = cb("prev_entry"),
                ["<cr>"]          = cb("select_entry"),
                ["o"]             = cb("select_entry"),
                ["<2-LeftMouse>"] = cb("select_entry"),
                ["<tab>"]         = cb("select_next_entry"),
                ["<s-tab>"]       = cb("select_prev_entry"),
                ["gf"]            = cb("goto_file"),
                ["<C-w><C-f>"]    = cb("goto_file_split"),
                ["<C-w>gf"]       = cb("goto_file_tab"),
                ["<leader>e"]     = cb("focus_files"),
                ["<leader>b"]     = cb("toggle_files"),
            },
            option_panel = {
                ["<tab>"] = cb("select"),
                ["q"]     = cb("close"),
            },
        },
    }
end

function M.Conflict()
    require('git-conflict').setup {
        default_mappings = false,    -- disable buffer local mapping created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = {
            -- They must have background color, otherwise the default color will be used
            incoming = 'DiffText',
            current = 'DiffAdd',
        }
    }

    vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
    vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
    vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
    vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
    vim.keymap.set('n', 'cn', '<Plug>(git-conflict-prev-conflict)')
    vim.keymap.set('n', 'cp', '<Plug>(git-conflict-next-conflict)')
end

function M.GitSigns()
    vim.cmd([[
        highlight MyGitSignsAdd guifg=Green guibg=normal cterm=bold
        highlight MyGitSignsDelete guifg=Red guibg=normal cterm=bold
        highlight MyGitSignsChange guifg=#b58900 guibg=normal cterm=bold
        highlight GitSignsCurrentLineBlame guifg=DarkOrange guibg=normal cterm=bold
    ]])

    require('gitsigns').setup {
        signs                        = {
            add          = { hl = 'MyGitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = {
                hl = 'MyGitSignsChange',
                text = '│',
                numhl = 'GitSignsChangeNr',
                linehl = 'GitSignsChangeLn'
            },
            delete       = { hl = 'MyGitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d %H:%M> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm                         = {
            enable = false
        },
        on_attach                    = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<Up>', gs.prev_hunk)
            map('n', '<Down>', gs.next_hunk)
            map('n', '<leader>hb', function() gs.blame_line { full = true } end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)

            -- Text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
    }
end

return M
