return {
	"tpope/vim-commentary",
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	{
		"hat0uma/csvview.nvim",
		opts = { view = { display_mode = "border" } },
	},
	{
		"stevearc/oil.nvim",
		--@module "oil"
		--@type oil.SetupOpts
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "[F]ile [T]ree" },
		},
		lazy = false,
		opts = {
			columns = {},
			-- columns = { "icon", "permissions", "size", "mtime", },
			keymaps = {
				["<C-p>"] = { "actions.preview", opts = { vertical = true, split = "botright" } },
			},
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
				case_insensitive = true,
			},
			float = {
				preview_split = "left",
			},
		},
	},
	{
		"chomosuke/typst-preview.nvim",
		lazy = false,
		version = "1.*",
		opts = {},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "[F]ind [F]iles" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "[F]ind [G]rep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "[F]ind [B]uffer" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "[F]ind [H]elp" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostic" },
		},
		cmd = "Telescope",
	},
	{
		"saghen/blink.cmp",
		version = "*",
		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			signature = {
				enabled = true,
				window = { show_documentation = true },
			},
			completion = {
				documentation = { window = { border = "bold" } },
				menu = { auto_show = true, border = "bold" },
			},
			keymap = {
				["<C-k>"] = false,
				["<C-y>"] = false,
				["<S-Tab>"] = false,
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"fallback",
				},
			},
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
	{
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
					lualine_a = {},
					lualine_b = { "filename", "branch", "diagnostics" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "encoding", "filetype", "filesize", "progress" },
					lualine_z = { "location" },
				},
				tabline = {},
				extensions = { "oil" },
			})
		end,
	},
	"neovim/nvim-lspconfig",
	"nvimtools/none-ls.nvim",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	"tridactyl/vim-tridactyl",
}
