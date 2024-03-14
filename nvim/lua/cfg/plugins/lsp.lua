local function on_attach(client, bufnr)
	local function nmap(key, action, desc)
		vim.keymap.set("n", key, action, { buffer = bufnr, desc = desc })
	end

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efintion")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("[d", vim.diagnostic.goto_next, "Goto Next [D]iagnostic")
	nmap("]d", vim.diagnostic.goto_prev, "Goto Previous [D]iagnostic")

	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")

	require("inlay-hints").on_attach(client, bufnr)
end

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
			"folke/neodev.nvim",
		},
		cond = not vim.g.vscode,
		config = function()
			require("neodev").setup()

			require("mason").setup()
			require("mason-lspconfig").setup({
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
		cond = not vim.g.vscode,
		version = "^3",
		ft = { "rust" },
	},
	{
		"simrat39/inlay-hints.nvim",
		cond = not vim.g.vscode,
		config = function()
			require("inlay-hints").setup({
				renderer = "inlay-hints/render/eol",
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		cond = not vim.g.vscode,
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
}
