-- Session management
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
require("auto-session").setup({
	suppressed_dirs = { "~/", "~/projects", "~/Downloads", "/" },
  pre_save_cmds = { 'Neotree close', 'wa'},
  post_restore_cmds = { 'Neotree filesystem show'}
})
