local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50

vim.filetype.add({
	extension = {
		wgsl = "wgsl",
	},
})

if vim.g.vscode then
	require("cfg.remap.vscode")
else
	vim.keymap.set("n", "<C-u>", "<C-u>zz")
	vim.keymap.set("n", "<C-d>", "<C-d>zz")
	vim.keymap.set("n", "n", "nzzzv")
	vim.keymap.set("n", "N", "Nzzzv")

	vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
	vim.keymap.set("x", "<leader>p", [["_dP]])

	vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
	vim.keymap.set("x", " md", ":!prettier --parser markdown<CR>", { desc = "Format [M]ark[d]own Range" })

	vim.opt.nu = true
	vim.opt.relativenumber = true
end

require("lazy").setup("cfg.plugins")
