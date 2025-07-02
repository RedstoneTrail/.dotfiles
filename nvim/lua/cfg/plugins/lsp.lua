vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efintion" })
vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
	{ desc = "Goto Next [D]iagnostic" })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
	{ desc = "Goto Previous [D]iagnostic" })

vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
	{ desc = "[W]orkspace [S]ymbols" })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover Documentation" })
vim.keymap.set("n", "<leader>ih", ":InlayHintsToggle<CR>", { desc = "LSP: Toggle [I]nlay [H]ints" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

vim.g.rustaceanvim = {
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}


return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup({ PATH = "append" })
			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {
					"rust_analyzer",
					"lua_ls",
					"zls",
				},
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,
					-- rustaceanvim handles this
					rust_analyzer = function() end,
				},
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
}
