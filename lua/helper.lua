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

function helper.Maps(maps)
    for _, item in ipairs(maps) do
        local cmd = ""
        for _, piece in ipairs(item) do
            cmd = cmd .. " " .. piece
        end
        vim.cmd(cmd)
    end
end

function helper.DirectoryExists(directory)
  local stat = vim.loop.fs_stat(directory)
  if stat and stat.type == 'directory' then
    return true
  else
    return false
  end
end

return helper
