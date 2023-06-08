local M = {}

function M.fn()
    local lualine = require("lualine")
    local helper = require("helper")
    -- local gps = require("nvim-gps")

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
                    helper.get_root_path, -- color = { fg = '#287BC9' }, color = { fg = 'white', gui = 'bold' }, icon = { '😄' }
                },
                -- {
                --     'filename',
                --     path = 1,
                --     icon = { '😊' },
                --     -- color = { fg = '#2D9799' },
                --     color = { fg = '#FEDE5B'},
                -- },
                {
                    -- icon = { "🤠" },
                    -- gps.get_location,
                    -- cond = gps.is_available,
                    -- --color = { fg = '#ffaa88', gui = 'italic,bold' }
                    -- color = { fg = 'white' }
                },
            },
            lualine_z = {
                {
                    'location'
                },
                -- {
                --     icon = { "〽️" },
                --     require("my").get_stock_price
                -- },
                -- {
                --     icon = { "⏰" },
                --     helper.get_time_str,
                -- },
            },
        },
        extensions = {
        }
    })
end

return M
