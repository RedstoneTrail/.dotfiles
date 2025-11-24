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
vim.cmd("hi Pmenu guibg=#000000")
vim.cmd("hi BlinkCmpMenuBorder guifg=#00aa00")
vim.cmd("hi BlinkCmpDocBorder guifg=#005500")
vim.cmd("hi BlinkCmpMenuSelection guibg=#424242")
vim.cmd("hi FloatBorder guifg=#00aa00")
vim.opt.termguicolors = true

vim.diagnostic.config({
	float = {
		border = "bold",
	},
})
vim.o.winborder = "bold"

set("n", "<leader>ui", ":Telescope unicode_picker\n")

_G.coauthorfunc = function(findstart, base)
	-- :h complete-functions
	if findstart == 1 then
		return 0
	end

	local co_authors = vim.fn.systemlist('git -c log.showSignature=false log --format="%aN <%aE>" | sort -u')

	local items = {}
	for _, co_author in pairs(co_authors) do
		if co_author:lower():find(base) then
			table.insert(items, ("Co-authored-by: %s"):format(co_author))
		end
	end

	return items
end

vim.keymap.set("i", "<C-x><C-a>", "<cmd>set completefunc=v:lua.coauthorfunc<CR><C-x><C-u>")

require("lazy").setup("config.plugins")
