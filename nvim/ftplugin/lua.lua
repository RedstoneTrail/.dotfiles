require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.1",
			},
		},
	},
})
