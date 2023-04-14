if not vim.g.vscode then
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
end
