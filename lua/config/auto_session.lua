-- Session management
require("auto-session").setup({
	-- Stops Neotree from getting in the way of the session
	pre_save_cmds = { "Neotree close" },
	post_restore_cmds = { "Neotree filesystem show left" },
	suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
})
