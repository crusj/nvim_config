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

return my
