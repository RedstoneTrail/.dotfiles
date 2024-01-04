local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_on_save,
	callback = function(ev)
		vim.lsp.buf.format({ bufnr = ev.buf })
	end,
})

vim.diagnostic.config({
	virtual_text = true,
})

vim.o.signcolumn = "yes"

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

	if client.name == "rust_analyzer" then
		local rust_tools = require("rust-tools")
		rust_tools.inlay_hints.enable()
		nmap("K", rust_tools.hover_actions.hover_actions, "Hover Documentation")
	else
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
	rust_analyzer = {
		settings = require("cfg.lsp.settings.rust_analyzer"),
	},
	lua_ls = true,
	zls = true,
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
		init = function()
			require("neodev").setup()

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,
					rust_analyzer = function() end,
				},
			})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust", "rs" },
		cond = not vim.g.vscode,
		config = function()
			require("rust-tools").setup({
				capabilites = capabilities,
				on_attach = on_attach,
				settings = servers.rust_analyzer.settings,
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
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.completion.spell,
				},
			})
		end,
	},
}
