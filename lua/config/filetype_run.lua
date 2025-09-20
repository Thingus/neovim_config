local filetype_run = {
	["rust"] = "FloatermNew cargo build",
	["toml"] = "FloatermNew cargo build",
	["python"] = function()
		python_filetype_run()
	end,
	["lua"] = "FloatermNew lua",
	["elixir"] = "FloatermNew --autoclose=0 elixir %",
}

function python_filetype_run()
	if vim.api.nvim_buf_get_name(0):match(".ipynb$") then
		vim.cmd("MoltenReevaluateAll")
	else
		vim.cmd("FloatermNew --pwd=<root> --autoclose=0 uv run %")
	end
end

function get_runner(filetype)
	if not filetype_run[filetype] then
		vim.cmd("lua print('No runner set; check filetype_run.lua')")
	elseif type(filetype_run[filetype]) == "string" then
		vim.cmd(filetype_run[filetype])
	else
		filetype_run[filetype]()
	end
end

return get_runner
