vim.api.nvim_create_user_command("Dbee", function()
	vim.cmd("lua require('dbee').open()")
end, {})
