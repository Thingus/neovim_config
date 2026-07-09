-- Theming and some defaults
vim.cmd.colorscheme("catppuccin")
require("lualine").setup({ theme = "horizon" })
vim.o.signcolumn = "number"
vim.o.winborder = "rounded"

-- Rainbow-delimiters

require("rainbow-delimiters.setup").setup({
	strategy = {
		[""] = "rainbow-delimiters.strategy.global",
	},
	query = {
		[""] = "rainbow-delimiters",
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
	blacklist = { "c", "cpp" },
})

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldexpr = 99
