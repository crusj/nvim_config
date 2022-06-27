local helper = {}

function helper.get_root_path()
    local cwd = vim.fn.getcwd():split("/")
    return cwd[#cwd]
end

function helper.get_time_str()
    return os.date("%Y-%m-%d %H:%M", os.time())
end

function string:split(sep)
    local cuts = {}
    for v in string.gmatch(self, "[^'" .. sep .. "']+") do
        table.insert(cuts, v)
    end
    return cuts
end

return helper
