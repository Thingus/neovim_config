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
-- vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- default settings for Origami
require("origami").setup({
	useLspFoldsWithTreesitterFallback = {
		enabled = true,
		foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
	},
	pauseFoldsOnSearch = true,
	foldtext = {
		enabled = true,
		padding = {
			character = " ",
			width = 3, ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
			hlgroup = nil,
		},
		lineCount = {
			template = "%d lines", -- `%d` is replaced with the number of folded lines
			hlgroup = "Comment",
		},
		diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
		gitsignsCount = true, -- requires `gitsigns.nvim` or `mini.diff`
		disableOnFt = { "snacks_picker_input" }, ---@type string[]
	},
	autoFold = {
		enabled = true,
		kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
	},
	foldKeymaps = {
		setup = true, -- modifies `h`, `l`, `^`, and `$`
		closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
		scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
	},
})
