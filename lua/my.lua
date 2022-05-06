local my     = {}
local notify = require("notify")

vim.cmd([[
highlight NotifyWARNIcon guifg=Green
highlight NotifyINFOBorder guifg=Green
highlight NotifyINFOTitle guifg=Green
]])

function my.generate_go_tags()
	local cwd = vim.fn.getcwd()
	local cmd = "rm tags && gotags -R " .. cwd .. " > tags"
	vim.fn.jobstart(cmd, {
		on_exit = function()
			if vim.loop.fs_stat(cwd .. "/tags") then
				notify.notify("Success", "info", {
					title = "Generate go tags",
				})
			end
		end
	})
end

return my
