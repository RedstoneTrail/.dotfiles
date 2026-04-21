local set = vim.keymap.set

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

vim.opt.clipboard = "unnamedplus"

vim.opt.spelllang = "en"

vim.opt.mouse = ""

vim.opt.wrap = false

vim.opt.cursorline = true
vim.cmd("hi CursorLine guibg=#077000")

vim.opt.cursorcolumn = true
vim.cmd("hi CursorColumn guibg=#077000")

vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 10

vim.opt.list = true

-- styling
vim.cmd("hi Normal guibg=default")
vim.cmd("hi NormalFloat guibg=default")
vim.cmd("hi Pmenu guibg=#000000")
vim.cmd("hi PmenuBorder guifg=#00aa00")
vim.cmd("hi FloatBorder guifg=#00aa00")
vim.cmd("hi StatusLine guibg=#000000")
vim.opt.termguicolors = true

vim.opt.pumborder = "single"
vim.opt.pumheight = 10

vim.opt.winborder = "single"

vim.diagnostic.config({
	float = {
		border = "bold",
	},
})
vim.o.winborder = "bold"

vim.o.completeopt = "menuone,popup"


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
