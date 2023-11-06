local function call_vscode_cmd(cmd)
	vim.api.nvim_call_function("VSCodeNotify", { cmd })
end

local function get_vscode_cmd(cmd)
	return function()
		call_vscode_cmd(cmd)
	end
end

-- Toggle zen mode using `<leader>z`
vim.keymap.set("n", "<leader>z", get_vscode_cmd("extension.toggleZenMode"))

vim.keymap.set("n", "[d", get_vscode_cmd("editor.action.marker.next"))
vim.keymap.set("n", "]d", get_vscode_cmd("editor.action.marker.prev"))
vim.keymap.set("n", "<leader>ft", get_vscode_cmd("workbench.view.explorer"))

-- Live share panel using `<leader>sh`
vim.keymap.set("n", "<leader>sh", get_vscode_cmd("liveshare.session.focus"))

-- Hide panels using `<leader>h`
vim.keymap.set("n", "<leader>h", function()
	call_vscode_cmd("workbench.action.closeSidebar")
	call_vscode_cmd("workbench.action.closePanel")
end)

-- Command pallete using `<leader>pp`
vim.keymap.set("n", "<leader>pp", get_vscode_cmd("workbench.action.showCommands"))

-- Find workspace using `<leader>fw`
vim.keymap.set("n", "<leader>fw", get_vscode_cmd("workbench.action.openRecent"))

vim.api.nvim_create_user_command("Git", function()
	call_vscode_cmd("workbench.scm.focus")
end, {})
