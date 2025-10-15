return {
	"nvim-lualine/lualine.nvim",
	dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },

	init = function()
		local colours = {
			black = "#000000",
			red = "#aa0000",
			green = "#00aa00",
			yellow = "#aa5500",
			blue = "#0000aa",
			magenta = "#aa00aa",
			cyan = "#00aaaa",
			white = "#aaaaaa",
			bblack = "#555555",
			bred = "#ff5555",
			bgreen = "#55ff55",
			byellow = "#ffff55",
			bblue = "#5555ff",
			bmagenta = "#ff55ff",
			bcyan = "#55ffff",
			bwhite = "#ffffff",
		}

		local custom_theme = {
			normal = {
				a = { fg = colours.bwhite, bg = colours.bblack },
				b = { fg = colours.white, bg = colours.black },
				c = { fg = colours.white, bg = colours.black },
				x = { fg = colours.white, bg = colours.black },
				y = { fg = colours.white, bg = colours.black },
				z = { fg = colours.bwhite, bg = colours.bblack },
			},

			insert = { a = { fg = colours.bwhite, bg = colours.green } },
			visual = { a = { fg = colours.bwhite, bg = colours.magenta } },
			replace = { a = { fg = colours.bwhite, bg = colours.red } },
			command = { a = { fg = colours.bwhite, bg = colours.cyan } },
		}

		require("lualine").setup({
			options = {
				icons_enabled = false,
				theme = custom_theme,
				component_separators = { left = "/", right = "/" },
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename", "branch", "diagnostics" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "encoding", "filetype", "filesize", "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename", "branch", "diagnostics" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "encoding", "filetype", "progress" },
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = { "oil" },
		})
	end,
}
