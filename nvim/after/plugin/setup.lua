vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50

if vim.g.vscode then
	require("cfg.remap.vscode")
else
	vim.keymap.set("n", "<C-u>", "<C-u>zz")
	vim.keymap.set("n", "<C-d>", "<C-d>zz")
	vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

	vim.opt.nu = true
	vim.opt.relativenumber = true

	require("fidget").setup({
		window = {
			blend = 0
		}
	})
end
