if not vim.g.vscode then
	vim.g.neo_tree_remove_legacy_commands = 1
	require("neo-tree").setup({
		window = {
			position = "float"
		}
	})
	vim.keymap.set("n", "ft", ":Neotree float<CR>")
end
