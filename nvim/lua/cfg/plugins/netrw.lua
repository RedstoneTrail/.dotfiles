return {
	"prichrd/netrw.nvim",
	keys = {
		{ "<leader>ft", "<cmd>Ex<cr>", desc = "[F]ile [T]ree" },
	},
	config = function()
		vim.g.netrw_list_hide = "^\\..*,node_modules,target"
		vim.g.netrw_banner = 0
		require("netrw").setup()
	end,
	cond = not vim.g.vscode,
}
