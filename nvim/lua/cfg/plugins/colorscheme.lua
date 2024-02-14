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
				mason = true,
			},
			transparent_background = true,
			no_italic = true,
		})

		vim.cmd.colorscheme("catppuccin")

		local pallette = require("catppuccin.palettes.frappe")

		vim.api.nvim_set_hl(0, "SpellBad", {
			bg = pallette.red,
			fg = pallette.base,
		})
	end,
	lazy = false,
	priority = 1000,
}
