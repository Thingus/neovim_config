-- Theming and some defaults
vim.cmd.colorscheme("catppuccin")
require("lualine").setup({ theme = "horizon" })
vim.o.signcolumn = "number"
vim.o.winborder = "rounded"
