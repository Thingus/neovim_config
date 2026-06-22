return {
	-- Theme
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- Icons
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Surround (ysiw, ect)
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- iswap for swapping thiungs
	{
		"mizlan/iswap.nvim",
		event = "VeryLazy",
	},

	--treesitter (roots most of the lsp stuff)
	{
		"nvim-treesitter/nvim-treesitter",
		tag = "v0.10.0",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"python",
					"javascript",
					"typescript",
					"html",
					"css",
				},
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

	--mason; lsp manager
	{
		"williamboman/mason.nvim",
		opts = {},
	},

	-- -- nvim-lspconfig
	{
		"neovim/nvim-lspconfig",
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
	},

	-- Completion plugin
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
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
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

	-- ; nvim-lint; linter manager
	{
		"mfussenegger/nvim-lint",
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
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			-- fill any relevant options here
		},
	},

	-- Trouble; lsp bottom-bar project check
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble"
	},

	-- rustaceanvim: Rust dev plugin
	{
		"mrcjkb/rustaceanvim",
		dependencies = {
			"rust-lang/rust-analyzer",
		},
		version = "^6", -- Recommended
		lazy = false, -- This plugin is already lazy
	},

	-- auto-session; cwd-based session manager
	{
		"rmagatti/auto-session",
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
	},

	-- lualine: prettier bottom bar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- autoclose: auto-bracket closing
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},

	-- leap: fast Vimium-like nav
	{
		"https://codeberg.org/andyg/leap.nvim",
	},

	-- Jupynium; Jupyter notebook puppetteer
	{
		"kiyoon/jupynium.nvim",
		build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
		dependencies = {
			"rcarriga/nvim-notify", -- optional
			"stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
		},
	},

	-- FloatTerm; floating terminal for quick things
	{
		"voldikss/vim-floaterm",
	},

	-- Molten; ipython plugin
	{
		"benlubas/molten-nvim",
		version = "^1.0.0",
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_output_win_max_height = 12
		end,
	},

	--jupytext; opens .ipynbs as regular readable notebooks
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		--   -- lazy=false,
	},

	--telescope; jumps about the place using fzf
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	--live-preview; for webdev
	{
		"brianhuster/live-preview.nvim",
		dependencies = {
			-- You can choose one of the following pickers
			"nvim-telescope/telescope.nvim",
		},
	},

	--marp; for presentations (lets try it)
	{
		"mpas/marp-nvim",
		lazy = false,
	},

	--lazy
}
