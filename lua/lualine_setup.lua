local lualine = require("lualine")
local helper = require("helper")
local gps = require("nvim-gps")

lualine.setup({
    options = {
        theme = 'auto',
        component_separators = {},
        disabled_filetypes = {},
        section_separators = { left = '', right = '' },
    },
    globalstatus = true,
    sections = {
        lualine_a = {
            {
                'mode',
                padding = 1,

            }
        },
        lualine_c = {
            {
                helper.get_root_path,
                -- color = { fg = '#287BC9' },
                color = { fg = 'red' },
                icon = { '📦' }

            },
            {
                'filename',
                path = 1,
                -- color = { fg = '#2D9799' },
                color = { fg = '#FEDE5B' },
                icon = { '📜' }
            },
            {
                gps.get_location,

                cond = gps.is_available,
                --color = { fg = '#ffaa88', gui = 'italic,bold' }
                color = { fg = 'white', gui = 'italic,bold' }
            },
        },
        lualine_z = {
            {
                'location'
            },

            {
                icon = { "⏰" },
                helper.get_time_str,
            },
        },
    },
    extensions = {
    }
})
