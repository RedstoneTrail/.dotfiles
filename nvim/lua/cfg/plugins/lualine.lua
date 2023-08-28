return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	init = function()
		local lualine = require("lualine")

		lualine.setup({
			options = {
				theme = "catppuccin"
			}
		})

		-- vim.api.nvim_create_autocmd({ "LspProgressStatusUpdated" }, {
		-- 	group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true }),
		-- 	callback = lualine.refresh
		-- })
	end,
}
