local my = {}
function my.test()
	local output = vim.api.nvim_exec("grep func\\ main\\(\\) %", true)
	print(output)
end

function my.getlines()
	local lines = vim.api.nvim_buf_get_lines(0,1,-1,true)
	for _, v in ipairs(lines) do
		print(v)
	end
end

-- 
function my.session_started()
	local win = vim.api.nvim_get_current_win()
	vim.api.nvim_exec("NvimTreeOpen",{})
	vim.api.nvim_set_current_win(win)
	vim.api.nvim_exec("NvimTreeFindFile",{})
	vim.api.nvim_set_current_win(win)
end

return my
