return {
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		tag = "legacy",
		config = function()
			require("fidget").setup({
				window = {
					blend = 0
				}
			})
		end,
	},
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{ "alec-gibson/nvim-tetris",  cmd = "Tetris" },
	{ "tpope/vim-fugitive",       cmd = "Git" },
	"tpope/vim-commentary",
	-- "ggandor/leap.nvim"
}
