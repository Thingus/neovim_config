require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettier", stop_after_first = true },
		html = { "prettier" },
		css = { "prettier" },
		jinja = { "jinja-lsp" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
