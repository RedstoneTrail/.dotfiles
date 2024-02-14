vim.opt.spelllang = "en"
vim.opt.wrap = false

vim.api.nvim_create_user_command("WritingOn", function()
	vim.opt.spell = true
	vim.opt.linebreak = true
	vim.opt.wrap = true
end, {})

vim.api.nvim_create_user_command("WritingOff", function()
	vim.opt.spell = false
	vim.opt.linebreak = false
	vim.opt.wrap = false
end, {})
