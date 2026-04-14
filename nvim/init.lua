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

vim.opt.shiftwidth = 0

local function gh(x) return "https://github.com/" .. x end

vim.pack.add({
	gh("tpope/vim-commentary"),
	gh("hat0uma/csvview.nvim"),
})

require("csvview").setup({ view = { display_mode = "border" } })

vim.pack.add({
	gh("stevearc/oil.nvim"),
})

require("oil").setup({
	columns = {},
	-- columns = { "icon", "permissions", "size", "mtime", },
	keymaps = {
		["<C-p>"] = { "actions.preview", opts = { vertical = true, split = "botright" } },
	},
	watch_for_changes = true,
	view_options = {
		show_hidden = true,
		case_insensitive = true,
	},
	float = {
		preview_split = "left",
	},
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "[F]ile [T]ree" })

vim.pack.add({
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
})

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind [G]rep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "[F]ind [B]uffer" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "[F]ind [D]iagnostic" })

vim.pack.add({
	gh("nvim-lualine/lualine.nvim"),
})

local lualine_colours = {
	black = "#000000",
	red = "#aa0000",
	green = "#00aa00",
	yellow = "#aa5500",
	blue = "#0000aa",
	magenta = "#aa00aa",
	cyan = "#00aaaa",
	white = "#aaaaaa",
	bblack = "#555555",
	bred = "#ff5555",
	bgreen = "#55ff55",
	byellow = "#ffff55",
	bblue = "#5555ff",
	bmagenta = "#ff55ff",
	bcyan = "#55ffff",
	bwhite = "#ffffff",
}

local lualine_theme = {
	normal = {
		a = { fg = lualine_colours.bwhite, bg = lualine_colours.bblack },
		b = { fg = lualine_colours.white, bg = lualine_colours.black },
		c = { fg = lualine_colours.white, bg = lualine_colours.black },
		x = { fg = lualine_colours.white, bg = lualine_colours.black },
		y = { fg = lualine_colours.white, bg = lualine_colours.black },
		z = { fg = lualine_colours.bwhite, bg = lualine_colours.bblack },
	},

	insert = { a = { fg = lualine_colours.bwhite, bg = lualine_colours.green } },
	visual = { a = { fg = lualine_colours.bwhite, bg = lualine_colours.magenta } },
	replace = { a = { fg = lualine_colours.bwhite, bg = lualine_colours.red } },
	command = { a = { fg = lualine_colours.bwhite, bg = lualine_colours.cyan } },
}

require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = lualine_theme,
		component_separators = { left = "/", right = "/" },
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "filename", "branch", "diagnostics" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "encoding", "filetype", "filesize", "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { "filename", "branch", "diagnostics" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "encoding", "filetype", "filesize", "progress" },
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = { "oil" },
})

vim.pack.add({
	gh("neovim/nvim-lspconfig"),
	gh("nvimtools/none-ls.nvim"),
	gh("folke/lazydev.nvim"),
})

require("lazydev").setup({})

vim.pack.add({
	gh("mrcjkb/rustaceanvim"),
})

vim.cmd.packadd("nvim.undotree")

-- require("lazy").setup("config.plugins")
