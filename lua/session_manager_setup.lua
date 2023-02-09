-- local Path = require('plenary.path')
-- require('session_manager').setup({
--     sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
--     path_replacer = '__', -- The character to which the path separator will be replaced for session files.
--     colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
--     autoload_mode = 'Disabled', -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
--     autosave_last_session = true, -- Automatically save last session on exit and on session switch.
--     autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
--     autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
--         'structure-go',
--         'gitcommit',
--         'NvimTree',
--         'hierarchy-tree-go',
--         'vimwiki'
--     },
--     autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
--     max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
-- })
-- vim.keymap.set("n", "<space>s", "<cmd>SessionManager load_session<cr>", { silent = true })

require("persisted").setup({
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
    command = "VimLeavePre", -- the autocommand for which the session is saved
    silent = false, -- silent nvim message when sourcing session file
    use_git_branch = true, -- create session files based on the branch of the git enabled repository
    autosave = true, -- automatically save session files when exiting Neovim
    should_autosave = nil, -- function to determine if a session should be autosaved
    autoload = false, -- automatically load the session for the cwd on Neovim startup
    on_autoload_no_session = nil, -- function to run when `autoload = true` but there is no session to load
    follow_cwd = false, -- change session file name to match current working directory if it changes
    allowed_dirs = {
        "~/Project",
        "~/.config"
    }, -- table of dirs that the plugin will auto-save and auto-load from
    ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
    before_save = nil, -- function to run before the session is saved to disk
    after_save = nil, -- function to run after the session is saved to disk
    after_source = nil, -- function to run after the session is sourced
    telescope = { -- options for the telescope extension
        before_source = function() -- function to run before the session is sourced via telescope
        end,
        after_source = function()
        end, -- function to run after the session is sourced via telescope
        reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
    },

})
require("telescope").load_extension("persisted") -- To load the telescope extension
vim.keymap.set("n", "<space>s", "<cmd>Telescope persisted<cr>", { silent = true })
