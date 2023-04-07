vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50

require("cfg.remap")

vim.cmd("colorscheme onedark")

if not vim.g.vscode then
	vim.opt.nu = true
	vim.opt.relativenumber = true

	require("fidget").setup({})
end
