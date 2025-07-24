-- Session management
require("auto-session").setup({
	-- Stops Neotree from getting in the way of the session
	suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
})
