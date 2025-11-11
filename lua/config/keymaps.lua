-- Setting Leader to space
vim.g.mapleader = " "

-- Tabbing
vim.wo.number = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Opening vsplits to the right
vim.o.splitright = true

-- Opening splits at the bottom
vim.o.splitbelow = true

-- Window movement
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- And for the terminal
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l")

-- Autocomplete via luasnip
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<Tab>", function()
	-- if ls.expand_or_jumpable() then
	ls.expand_or_jump()
	-- else
	--   '<Tab>'
	-- end
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
vim.keymap.set({ "n" }, "<leader>F", function()
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
end, { desc = "Closes the Neotree pane" })

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

-- Telescope jumping around
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Lsp diagnostic toggle
vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

-- Lsp diagnostic show
vim.keymap.set("n", "<leader>a", function()
	vim.diagnostic.open_float()
end)

-- Lsp gotos
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

-- Swanky autorename from https://blog.viktomas.com/graph/neovim-lsp-rename-normal-mode-keymaps/
vim.keymap.set("n", "<leader>e", vim.lsp.buf.rename)

-- Instant terminal
vim.keymap.set({ "n" }, "<leader>t", ":FloatermNew<CR>")

-- Lazygit
vim.keymap.set({ "n" }, "<leader>gg", ":FloatermNew --height=0.8 --width=0.8 lazygit<CR>")

-- Home- grown run cmd (context dependent)
filetype_runners = require("config.filetype_run")
vim.keymap.set({ "n" }, "<leader>r", function()
	filetype_runners(vim.bo.filetype)
end)

-- Session picker from auto_session
vim.keymap.set({ "n" }, "<leader>u", ":AutoSession search<CR>")

-- norm command for selecting text in a Jupyvim cell
-- norm ?# %%^MV/# %%^Mk
