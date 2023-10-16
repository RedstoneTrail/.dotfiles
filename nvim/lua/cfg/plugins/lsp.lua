local prettier_filetypes = {
	css = true,
	graphql = true,
	html = true,
	javascript = true,
	javascriptreact = true,
	json = true,
	less = true,
	markdown = true,
	scss = true,
	typescript = true,
	typescriptreact = true,
	yaml = true,
}

local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true });

vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_on_save,
	callback = function(ev)
		local ft = vim.fn.getbufvar(ev.buf, "&filetype")
		if prettier_filetypes[ft] then
			return
		end

		vim.lsp.buf.format({ bufnr = ev.buf })
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = format_on_save,
	callback = function(ev)
		local ft = vim.fn.getbufvar(ev.buf, "&filetype")
		if not prettier_filetypes[ft] then
			return
		end

		vim.cmd("!prettier % --use-tabs -w")
	end,
})

vim.diagnostic.config({
	virtual_text = true
})

vim.o.signcolumn = "yes"

local on_attach = nil
local capabilities = nil
local servers = {
	rust_analyzer = {
		settings = require("cfg.lsp.settings.rust_analyzer")
	},
	lua_ls = true,
	zls = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
		"simrat39/rust-tools.nvim",
	},
	init = function()
		capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		on_attach = function(client, bufnr)
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

			nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols,
				"[D]ocument [S]ymbols")
			nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
				"[W]orkspace [S]ymbols")

			if client.name == "rust_analyzer" then
				local rust_tools = require("rust-tools")
				rust_tools.inlay_hints.enable()
				nmap("K", rust_tools.hover_actions.hover_actions, "Hover Documentation")
			else
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			end
		end

		require("rust-tools").setup({
			capabilites = capabilities,
			on_attach = on_attach,
			settings = servers.rust_analyzer.settings
		})

		require("neodev").setup()

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			handlers = {
				function(server_name)
					local config = servers[server_name]

					if type(config) ~= "table" then
						config = {}
					end

					config = vim.tbl_deep_extend("force", {
						capabilities = capabilities,
						on_attach = on_attach
					}, config)

					require("lspconfig")[server_name].setup(config)
				end,
			},
		})
	end,
}
