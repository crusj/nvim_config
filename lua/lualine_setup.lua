local lualine = require("lualine")
local helper = require("helper")
local gps = require("nvim-gps")

lualine.setup({
    options = {
        theme = 'solarized_light',
        component_separators = { left = '', right = '' },
        disabled_filetypes = {},
        section_separators = { left = '', right = '' },
    },
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

            },
            {
                'filename',
                path = 1,
            },
            {
                gps.get_location,

                cond = gps.is_available
            },
        },
        lualine_z = {
            {
                'location'
            },

            {
                helper.get_time_str,

            },
        },
    },
    extensions = {
    }
})
