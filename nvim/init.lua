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

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

vim.filetype.add({
	extension = {
		wgsl = "wgsl",
	},
})

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-Tab>", ":tabn")

vim.opt.nu = true
vim.opt.rnu = true

vim.opt.signcolumn = "yes"

vim.diagnostic.config({
	virtual_text = true,
})

require("cfg.autoformat")
require("cfg.writing")
require("cfg.dbee")

require("lazy").setup("cfg.plugins")

vim.opt.spelllang = "en"

vim.opt.mouse = ""

vim.opt.showmode = false

vim.opt.cursorline = true
vim.cmd("hi CursorLine guibg=#033000")

vim.opt.cursorcolumn = true
vim.cmd("hi CursorColumn guibg=#033000")

vim.opt.list = true

vim.opt.scrolloff = 10
