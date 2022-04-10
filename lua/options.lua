local function load_options()
	local global_options = {
		background = "light",
		termguicolors = true,
		hidden = true,
		autowrite = true,
		ignorecase = true,
		ts = 4,
		shiftwidth = 4,
		mouse = "a",
		nu = true,
		rnu = true,
		cursorline = true,
		clipboard = "unnamedplus",
		backspace = "indent,eol,start",
		-- foldmethod = "indent",
		signcolumn = "yes",
		shell = "/bin/bash",
	}

	for option,value in pairs(global_options) do
		vim.o[option] = value
	end
end
load_options()

