require("lint").linters_by_ft = {
	lua = { "luacheck" },
	-- python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
	python = { "pylint" },
	javascript = { "eslint" },
	typescript = { "typescript-eslint" },
	typescriptreact = { "typescript-eslint" },
	html = { "htmlhint" },
	-- css = { "stylelint" },
	jinja = { "jinja-lsp" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
