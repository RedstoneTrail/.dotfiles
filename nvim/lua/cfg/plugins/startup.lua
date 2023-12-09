return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require 'alpha'
		local startify = require 'alpha.themes.startify'

		startify.section.top_buttons.val = {
			startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		}

		startify.section.mru_cwd.val = { { type = "padding", val = 0 } }

		startify.section.bottom_buttons.val = {
			startify.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(startify.config)
	end
}
