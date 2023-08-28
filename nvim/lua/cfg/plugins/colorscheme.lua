return {
	"catppuccin/nvim",
	name = "catppuccin",
	init = function()
		vim.opt.termguicolors = true
		require("catppuccin").setup({
			flavour = "frappe",
			integrations = {
				telescope = true,
				neotree = true,
				cmp = true,
				fidget = true,
				mason = true
			},
			transparent_background = true,
			no_italic = true
		})

		vim.cmd.colorscheme("catppuccin")
	end,
	lazy = false,
	priority = 1000,
}
