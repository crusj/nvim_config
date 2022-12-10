require 'mind'.setup {
    ui = {
        icon_preset = {
            { " ", "Sub-project" },
            { " ", "Journal, newspaper, weekly and daily news" },
            { " ", "For when you have an idea" },
            { " ", "Note taking?" },
            { "陼", "Task management" },
            { " ", "Uncheck, empty square or backlog" },
            { " ", "Full square or on-going" },
            { " ", "Check or done" },
            { " ", "Trash bin, deleted, cancelled, etc." },
            { " ", "GitHub" },
            { " ", "Monitoring" },
            { " ", "Internet, Earth, everyone!" },
            { " ", "Frozen, on-hold" },
            { "", "Delete" },
            {" ", "Unfinished"}
        }
    }

}

vim.keymap.set("n", "<space>mm", ":MindOpenMain<CR>", { silent = true })
vim.keymap.set("n", "<space>mn", ":MindOpenProject<CR>", { silent = true })
