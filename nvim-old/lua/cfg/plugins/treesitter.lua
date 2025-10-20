return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"json",
					"markdown",
					"query",
					"toml",
					"vim",
				},

				highlight = {
					enable = true,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn", -- maps in normal mode to init the node/scope selection
						node_incremental = "grn", -- increment to the upper named parent
						node_decremental = "grc", -- decrement to the previous node
						scope_incremental = "grm", -- increment to the upper scope (as defined in locals.scm)
					},
				},

				textobjects = {
					move = {
						enable = true,
						set_jumps = true,

						goto_next_start = {
							["]p"] = "@parameter.inner",
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[p"] = "@parameter.inner",
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},

					select = {
						enable = true,
						lookahead = true,

						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",

							["ac"] = "@conditional.outer",
							["ic"] = "@conditional.inner",

							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",

							["av"] = "@variable.outer",
							["iv"] = "@variable.inner",
						},
					},
				},

				playground = {
					enable = true,
					updatetime = 25,
					persist_queries = true,
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",

						-- This shows stuff like literal strings, commas, etc.
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			})
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
}
