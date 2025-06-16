-- Setting Leader to space
vim.g.mapleader = " "

-- Tabbing
vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Autocomplete via luasnip
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<Tab>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<Tab>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

-- Neotree
local nt = require("neo-tree.command")
vim.keymap.set({ "n" }, "<leader>f", function()
	nt.execute({
		action = "focus",
		source = "filesystem",
		toggle = false,
		position = "left",
	})
end, { desc = "Toggles and focusses the Neotree pane" })
vim.keymap.set({ "n" }, "<leader>g", function()
	nt.execute({
		action = "close",
		source = "filesystem",
	})
end, { desc = "Toggles and focusses the Neotree pane" })

-- Neotree file browser (hjkl for nav, ' f' for close)
require("neo-tree").setup({
	filesystem = {
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
			},
		},
	},
})

-- Lsp diagnostic toggle
vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })
