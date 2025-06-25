return {
	-- Theme?
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	--treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "rust" },
				auto_install = false,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>n",
						node_incremental = "<leader>n",
						scope_incremental = "<leader>s",
						node_decremental = "<leader>m",
					},
				},
			})
		end,
	},

	--luasnip
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		config = function()
			require("luasnip.loaders.from_lua").load({ paths = "../snippets" })
		end,
	},

	-- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = { "pyright", "html", "eslint" },
			})
			require("lspconfig").pyright.setup({
				capabilities = capabilities,
			})
		end,
	},

	--mason
	{
		"williamboman/mason.nvim",
	},

	--
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = {
					autocomplete = false,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<s-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<c-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
			})
		end,
	},

	-- confirm; formatter
	{
		"stevearc/conform.nvim",
		opts = {},
	},

	-- neotree; file browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- fill any relevant options here
		},
	},

	-- rustaceanvim: Rust dev plugin
	{
		"mrcjkb/rustaceanvim",
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	--

	-- auto-session; cwd-based session manager
	{
		"rmagatti/auto-session",
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
	},

	-- lualine: prettier bottom barjjj
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- autoclose: auto
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},

	-- Jupynium; Jupyter notebook puppetteer
	{
		"kiyoon/jupynium.nvim",
		build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
	},
	"rcarriga/nvim-notify", -- optional
	"stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect

	-- FloatTerm; floating terminal for quick things
	{
		"voldikss/vim-floaterm",
	},
}
