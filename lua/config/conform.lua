require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		javascript = { "eslint", "prettier", stop_after_first = true },
		html = { "prettier" },
		css = { "prettier" },
		jinja = { "jinja-lsp" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
