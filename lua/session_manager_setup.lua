require('auto-session').setup {
	auto_session_enable_last_session = true,
	auto_save_enabled = true,
	auto_restore_enabled = true,
	pre_save_cmds = { "NvimTreeClose" },
	post_restore_cmds = { "lua require'my'.session_started()" }
}
