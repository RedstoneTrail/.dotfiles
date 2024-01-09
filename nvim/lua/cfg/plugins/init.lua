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
	{ "alec-gibson/nvim-tetris",   cmd = "Tetris" },
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
	-- "ggandor/leap.nvim"
}
