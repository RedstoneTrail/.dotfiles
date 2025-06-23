return {
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		tag = "legacy",
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
				},
			})
		end,
	},
	{ "ThePrimeagen/vim-be-good",  cmd = "VimBeGood" },
	{ "RedstoneTrail/nvim-tetris", cmd = "Tetris" },
	{ "tpope/vim-fugitive",        cmd = "Git",           cond = not vim.g.vscode },
	{ "mbbill/undotree",           cmd = "UndotreeToggle" },
	{ "2kabhishek/co-author.nvim", cmd = "CoAuthor" },
	"tpope/vim-commentary",
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"hat0uma/csvview.nvim",
		opts = { view = { display_mode = "border" } },
	},
	{
		"kndndrj/nvim-dbee",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup( --[[optional config]])
		end,
	},
	{
		"cosmicboots/unicode_picker.nvim",
		dependencies = {
			"uga-rosa/utf8.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local unicode_picker = require("unicode_picker")
			unicode_picker.setup()
			vim.keymap.set("n", "<leader>ui", unicode_picker.unicode_chars,
				{ buffer = bufnr, desc = "[U]nicode [I]nsert" })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" }
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
	},
	{
		"saghen/blink.cmp",
		version = "*",
		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			signature = {
				enabled = true,
				window = { show_documentation = false },
			},
			completion = {
				-- ghost_text = { enabled = true },
				documentation = { window = { border = "single" } },
				menu = { auto_show = false, border = "single" },
			},
			keymap = {
				["<C-y>"] = {},
				["<S-Tab>"] = {},
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},
			-- snippets = { preset = "luasnip" },
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
}
