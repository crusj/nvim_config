local my = {}
function my.test()
	local output = vim.api.nvim_exec("grep func\\ main\\(\\) %", true)
	print(output)
end

return my
