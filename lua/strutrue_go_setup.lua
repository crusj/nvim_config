require "structrue-go".setup({
    show_filename = false,
    number = "nu",
    position = "botright",
    symbol = { -- symbol style
        filename = {
            hl = "guifg=#0096C7", -- highlight symbol
            icon = " " -- symbol icon
        },
        package = {
            hl = "guifg=#0096C7",
            icon = " "
        },
        import = {
            hl = "guifg=#E4475",
            icon = " ◈ "
        },
        const = {
            hl = "guifg=#E44755",
            icon = " π ",
        },
        variable = {
            hl = "guifg=#52A5A2",
            icon = " ◈ ",
        },
        func = {
            hl = "guifg=#7E7BE1",
            icon = "  ",
        },
        interface = {
            hl = "guifg=#00B4D8",
            icon = "❙ "
        },
        type = {
            hl = "guifg=#E15093",
            icon = "▱ ",
        },
        struct = {
            hl = "guifg=Purple",
            icon = "❏ ",
        },
        field = {
            hl = "guifg=#919191",
            icon = " ▪ "
        },
        method_current = {
            hl = "guifg=#4EA7F9",
            icon = " ƒ "
        },
        method_others = {
            hl = "guifg=#CEB996",
            icon = "  "
        },
    },
    keymap = {
        toggle = "<space>fh",
        fold_toggle = "o",
        center_symbol = "<space>fc",
        preview_open = "<space>fp"

    }
})
