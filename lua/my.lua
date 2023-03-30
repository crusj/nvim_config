local my     = {
    git_log_buf = nil,
    git_log_win = nil,
    op_buf = nil,
    op_win = nil,
    op_cache = {},
    op_commit_buf = nil,
    op_commit_win = nil,
    op_commit_cache = {},
    format_sync_grp = vim.api.nvim_create_augroup("GoFmt", {}),
    stock_price = "",
    stock_percent = "",
    getting_stock_price = false
}
local notify = require("notify")

vim.cmd([[
highlight NotifyWARNIcon guifg=Green
highlight NotifyINFOBorder guifg=Green
highlight NotifyINFOTitle guifg=Green
highlight NotifyINFOIcon guifg=Green
]])

vim.cmd(string.format("highlight hl_git_log_csl %s", "guibg=Gray guifg=White"))

-- generate go tags for project
function my.generate_go_tags()
    local cwd = vim.fn.getcwd()
    if not vim.loop.fs_stat(cwd .. "/go.mod") then
        notify.notify("Do not found go.mod", "error", {
            title = "Generate go tags",
        })
        return
    end

    local cmd = "gotags -R " .. cwd .. " > " .. cwd .. "/tags"
    if vim.loop.fs_stat(cwd .. "/tags") then
        cmd = "rm " .. cwd .. "/tags && " .. cmd
    end

    vim.fn.jobstart(cmd, {
        on_exit = function()
            if vim.loop.fs_stat(cwd .. "/tags") then
                notify.notify("Success", "info", {
                    title = "Generate go tags",
                })
            else
                notify.notify("Error", "error", {
                    title = "Generate go tags",
                })
            end
        end
    })
end

-- 关闭最近win
function my.close_last_git_win()
    if my.git_log_win ~= nil and vim.api.nvim_win_is_valid(my.git_log_win) then
        vim.api.nvim_win_close(my.git_log_win, true)
    end
end

-- 选择log
function my.choose_git_log()
    vim.fn.execute("normal! Vy")
    my.close_last_git_win()
end

-- copy 当前项目最近git log body信息
function my.copy_last_git_msg()
    if my.git_log_buf == nil then
        my.git_log_buf = vim.api.nvim_create_buf(false, true)

        -- bind buf keymap
        vim.api.nvim_buf_set_keymap(my.git_log_buf, "n", "<esc>", ":lua require'my'.close_last_git_win()<CR>",
            { silent = true })
        vim.api.nvim_buf_set_keymap(my.git_log_buf, "n", "<cr>", ":lua require'my'.choose_git_log()<CR>",
            { silent = true })
    end

    local lines = {}
    local cmd = "git log -10 --pretty=format:%B"
    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
            for _, line in pairs(data) do
                if line ~= "" then
                    lines[#lines + 1] = line
                end
            end
        end,
        on_exit = function()
            -- 计算高度
            local ew = vim.api.nvim_get_option("columns")
            local eh = vim.api.nvim_get_option("lines")
            local gw = math.floor(ew * 0.7)
            local gh = math.floor(eh * 0.7)
            my.git_log_win = vim.api.nvim_open_win(my.git_log_buf, true, {
                relative = "editor",
                width = gw,
                height = gh,
                row = math.floor((eh - gh) / 2),
                col = math.floor((ew - gw) / 2),
                border = "double",
            })

            -- vim.api.nvim_win_set_option(my.git_log_win, "winhighlight", "CursorLine:hl_git_log_csl")
            vim.api.nvim_buf_set_lines(my.git_log_buf, 0, #lines, false, lines)
        end
    })
end

-- 显示op
function my.open_op(refresh)
    if my.op_buf == nil then
        my.op_buf = vim.api.nvim_create_buf(false, true)

        -- bind buf keymap
        vim.api.nvim_buf_set_keymap(my.op_buf, "n", "<esc>", ":lua require'my'.close_op_win()<CR>",
            { silent = true })
        vim.api.nvim_buf_set_keymap(my.op_buf, "n", "<cr>", ":lua require'my'.choose_op()<CR>",
            { silent = true })
    end

    if #my.op_cache > 1 and refresh ~= true then
        my.open_op_win()
        return
    end

    local lines = {}
    local cmd = "op"
    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
            for _, line in pairs(data) do
                if line ~= "" then
                    lines[#lines + 1] = line
                end
            end
        end,
        on_exit = function()
            my.op_cache = lines
            my.open_op_win()
        end
    })
end

function my.open_op_win()
    local ew = vim.api.nvim_get_option("columns")
    local eh = vim.api.nvim_get_option("lines")
    local gw = math.floor(ew * 0.7)
    local gh = math.floor(eh * 0.7)
    my.op_win = vim.api.nvim_open_win(my.op_buf, true, {
        relative = "editor",
        width = gw,
        height = gh,
        row = math.floor((eh - gh) / 2),
        col = math.floor((ew - gw) / 2),
        border = "double",
    })

    -- vim.api.nvim_win_set_option(my.op_win, "winhighlight", "CursorLine:hl_git_log_csl")
    vim.api.nvim_buf_set_lines(my.op_buf, 0, #my.op_cache, false, my.op_cache)
end

-- 选择op
function my.choose_op()
    if my.op_commit_buf == nil then
        my.op_commit_buf = vim.api.nvim_create_buf(false, true)
        -- bind buf keymap
        vim.api.nvim_buf_set_keymap(my.op_commit_buf, "n", "<esc>", ":lua require'my'.close_op_commit_win()<CR>",
            { silent = true })
        vim.api.nvim_buf_set_keymap(my.op_commit_buf, "n", "<cr>", ":lua require'my'.copy_op_commit()<CR>",
            { silent = true })
    end
    local line = vim.fn.line(".")
    local lineContent = vim.fn.getbufline(my.op_buf, line, line)[1]
    local id
    for v in string.gmatch(lineContent, "%S+") do
        id = v
        break
    end

    local cmd = "op -id " .. id
    local lines = {}
    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
            for _, line in pairs(data) do
                if line ~= "" then
                    lines[#lines + 1] = line
                end
            end
        end,
        on_exit = function()
            my.close_op_win()
            my.op_commit_cache[id] = lines
            -- 计算高度
            my.open_op_commit_win(id)
        end
    })
end

function my.open_op_commit_win(id)
    local lines = my.op_commit_cache[id]

    local ew = vim.api.nvim_get_option("columns")
    local eh = vim.api.nvim_get_option("lines")
    local gw = math.floor(ew * 0.7)
    local gh = math.floor(eh * 0.7)
    my.op_commit_win = vim.api.nvim_open_win(my.op_commit_buf, true, {
        relative = "editor",
        width = gw,
        height = gh,
        row = math.floor((eh - gh) / 2),
        col = math.floor((ew - gw) / 2),
        border = "double",
    })

    -- vim.api.nvim_win_set_option(my.op_commit_win, "winhighlight", "CursorLine:hl_git_log_csl")
    vim.api.nvim_buf_set_lines(my.op_commit_buf, 0, #lines, false, lines)
end

function my.copy_op_commit()
    vim.fn.execute("normal! Vy")
    my.close_op_commit_win()
end

function my.close_others_buff()
    vim.cmd("BufferLineCloseRight")
    vim.cmd("BufferLineCloseLeft")
end

-- 关闭最近win
function my.close_op_win()
    if my.op_win ~= nil and vim.api.nvim_win_is_valid(my.op_win) then
        vim.api.nvim_win_close(my.op_win, true)
    end
end

-- 关闭op commit win
function my.close_op_commit_win()
    if my.op_commit_win ~= nil and vim.api.nvim_win_is_valid(my.op_commit_win) then
        vim.api.nvim_win_close(my.op_commit_win, true)
    end
end

-- go imports
function my.go_imports()
    my.clear_import()
    if vim.fn.getbufinfo("%")[1].changed == 1 then
        vim.cmd("write")
    end

    local file_name = vim.fn.expand("%:p")
    local cmd = "goimports " .. file_name
    local old_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.fn.jobstart(cmd, {
        on_exit   = function(_, data, _)
            my.add_import()
        end,
        on_stdout = function(_, new_lines, _)
            new_lines = my.handle_import(new_lines)
            if not new_lines then
                return
            end
            -- 相同检查
            if #new_lines == #old_lines then
                local is_same = true
                for k, v in ipairs(new_lines) do
                    if v ~= old_lines[k] then
                        is_same = false
                        break
                    end
                end
                if is_same then
                    print("✌️")
                    return
                end
            end

            vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
            local changed_lines = #new_lines - #old_lines
            vim.api.nvim_win_set_cursor(0, { cursor[1] + changed_lines, cursor[2] })
            old_lines = nil
            vim.cmd("write")
        end,
        on_stderr = function(_, data, _)
        end
    })
end

function my.handle_import(data)
    if not data then
        return nil
    end
    -- Because the nvim.stdout's data will have an extra empty line at end on some OS (e.g. maxOS), we should remove it.
    for _ = 1, 3, 1 do
        if data[#data] == '' then
            table.remove(data, #data)
        end
    end
    if #data < 1 then
        return nil
    end
    return data
end

function my.add_import()
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            require('my').go_imports()
        end,
        group = my.format_sync_grp,
    })
end

function my.clear_import()
    vim.api.nvim_clear_autocmds({
        event = "BufWritePre",
        pattern = "*.go",
        group = my.format_sync_grp
    })
end

function my.stock()
    if my.getting_stock_price == false then
        my.is_get_price = true
        vim.fn.jobstart("curl -s -H 'Referer: http://finance.sina.com.cn' 'http://hq.sinajs.cn/list=s_sh000001'", {
            on_stdout = function(_, data, _)
                if data[1] ~= nil and data[1] ~= "" then
                    local cuts = vim.split(data[1], ",")
                    my.stock_price = string.format("%.1f", cuts[2])
                    my.stock_percent = string.format("%.2f", cuts[4])
                end
            end,
            on_exit = function()
                my.is_get_price = false
            end
        })
    end
end

function my.get_stock_price()
    -- 判断当前时间为周一到周五的9:30-15:00
    if vim.fn.localtime().wday >= 2 and vim.fn.localtime().wday <= 6 and vim.fn.localtime().hour >= 9 and vim.fn.localtime().hour <= 15 then
        my.stock()
    end
    if my.stock_price ~= "" then
        return my.stock_price .. "|" .. my.stock_percent .. "%%"
    end

    return ""
end

return my
