return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "[F]ind [F]iles" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "[F]ind [G]rep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "[F]ind [B]uffer" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "[F]ind [H]elp" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostic" },
	},
	cmd = "Telescope",
	cond = not vim.g.vscode,
}
