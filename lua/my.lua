local my     = {
    git_log_buf = nil,
    git_log_win = nil,

    op_buf = nil,
    op_win = nil,
    op_cache = {},

    op_commit_buf = nil,
    op_commit_win = nil,
    op_commit_cache = {},
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
    local cmd = "git log -5 --pretty=format:%B"
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

            vim.api.nvim_win_set_option(my.git_log_win, "winhighlight", "CursorLine:hl_git_log_csl")
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

    vim.api.nvim_win_set_option(my.op_win, "winhighlight", "CursorLine:hl_git_log_csl")
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

    vim.api.nvim_win_set_option(my.op_commit_win, "winhighlight", "CursorLine:hl_git_log_csl")
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

return my
