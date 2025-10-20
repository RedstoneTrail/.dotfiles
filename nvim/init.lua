local set = vim.keymap.set

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

vim.diagnostic.config({
	virtual_text = true,
})

vim.g.mapleader = " "

set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

set("n", "n", "nzz")
set("n", "N", "Nzz")

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.signcolumn = "yes"

vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"

vim.opt.spelllang = "en"

vim.opt.mouse = ""

vim.opt.wrap = false

vim.opt.cursorline = true
vim.cmd("hi CursorLine guibg=#077000")

vim.opt.cursorcolumn = true
vim.cmd("hi CursorColumn guibg=#077000")

vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 20

vim.opt.list = true

vim.cmd("hi Normal guibg=default")
vim.cmd("hi NormalFloat guibg=default")
vim.opt.termguicolors = true

require("lazy").setup("config.plugins")
