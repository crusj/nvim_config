require('auto-session').setup {
	auto_save_enabled = true,
	auto_restore_enabled = true,
	pre_save_cmds = { "NvimTreeClose" ,"lua require\"structrue-go\".preview_close()","lua require\"structrue-go\".close()"},
	post_restore_cmds = { "NvimTreeOpen" }
}
