local function regExtensions()
	local cmp = require('cmp')
	cmp.setup.cmdline('/', {
		sources = {
			{ name = 'buffer' }
		}
	})

	cmp.setup.cmdline(':', {
		sources = cmp.config.sources({
			{ name = 'path' }
		},
		{
			{ name = 'cmdline' }
	})
})
end

regExtensions()
