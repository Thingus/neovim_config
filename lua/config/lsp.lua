-- Based on https://dotfiles.substack.com/p/native-lsp-in-neovim-012
require("mason").setup()

-- nb; I think this also turns them on??
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"jsonls",
		"stylua",
		"prettier",
		"basedpyright",
		"ruff",
		"docker-language-server",
		"matlab-language-server",
	},
})

require("mason-lspconfig").setup({
	automatic_enable = false,
})

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
})

vim.lsp.config("*", {
	root_markers = { ".git" },
	on_attach = function(client, bufnr)
		-- some clients support workspace diagnostics natively
		if client:supports_method("workspace/diagnostic", bufnr) then
			vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
		else
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
		end
	end,
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server", "--stdio" },
	filetypes = { "lua" },
})
vim.lsp.enable("lua_ls")

vim.lsp.enable("ruff")
vim.lsp.enable("typescript-language-server")

vim.lsp.config("html-lsp", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
})
vim.lsp.enable("html-lsp")

vim.lsp.config("css-lsp", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
})
vim.lsp.enable("css-lsp")

vim.lsp.config("docker-language-server", {
	cmd = { "docker-language-server", "start", "--stdio" },
	filetypes = { "dockerfile" },
})
vim.lsp.enable("docker-language-server")

vim.lsp.config("docker-compose-language-service", {
	cmd = { "docker-compose-language-service", "start", "--stdio" },
	filetypes = { "docker-compose" },
})
vim.lsp.enable("docker-compose-language-service")

vim.lsp.config("matlab-language-server", {
	cmd = { "matlab-language-server", "--stdio" },
	filetypes = { "matlab" },
})
vim.lsp.enable("matlab-language-server")
