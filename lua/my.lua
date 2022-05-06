local my     = {}
local notify = require("notify")

vim.cmd([[
highlight NotifyWARNIcon guifg=Green
highlight NotifyINFOBorder guifg=Green
highlight NotifyINFOTitle guifg=Green
highlight NotifyINFOIcon guifg=Green
]])

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

return my
