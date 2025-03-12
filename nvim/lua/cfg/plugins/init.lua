return {
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		tag = "legacy",
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
				},
			})
		end,
	},
	{ "ThePrimeagen/vim-be-good",  cmd = "VimBeGood" },
	{ "RedstoneTrail/nvim-tetris", cmd = "Tetris" },
	{ "tpope/vim-fugitive",        cmd = "Git",           cond = not vim.g.vscode },
	{ "mbbill/undotree",           cmd = "UndotreeToggle" },
	{ "2kabhishek/co-author.nvim", cmd = "CoAuthor" },
	"tpope/vim-commentary",
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"hat0uma/csvview.nvim",
		opts = { view = { display_mode = "border" } },
	},
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup( --[[optional config]])
		end,
	},
	{
		"cosmicboots/unicode_picker.nvim",
		dependencies = {
			"uga-rosa/utf8.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local unicode_picker = require("unicode_picker")
			unicode_picker.setup()
			vim.keymap.set("n", "<leader>ui", unicode_picker.unicode_chars,
				{ buffer = bufnr, desc = "[U]nicode [I]nsert" })
		end,
	}
}
