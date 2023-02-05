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

-- Toggle excluded files using `<leader>xf`
vim.keymap.set("n", "<leader>xf", get_vscode_cmd("toggleexcludedfiles.toggle"))

-- Show explorer using `<leader>ex`
vim.keymap.set("n", "<leader>ex", get_vscode_cmd("workbench.view.explorer"))

-- Live share panel using `<leader>sh`
vim.keymap.set("n", "<leader>sh", get_vscode_cmd("liveshare.session.focus"))

-- Focus terminal using `<leader>t`
vim.keymap.set("n", "<leader>t", get_vscode_cmd("terminal.focus"))

-- Goto symbol using `<leader>sy`
vim.keymap.set("n", "<leader>sy", get_vscode_cmd("workbench.action.gotoSymbol"))

-- Focus source control using `<leader>git`
vim.keymap.set("n", "<leader>git", get_vscode_cmd("workbench.scm.focus"))

-- Hide panels using `<leader>h`
vim.keymap.set("n", "<leader>h", function()
    call_vscode_cmd("workbench.action.closeSidebar")
    call_vscode_cmd("workbench.action.closePanel")
end)

-- Command pallete using `<leader>pp`
vim.keymap.set("n", "<leader>pp", get_vscode_cmd("workbench.action.showCommands"))

-- Current files using `<leader>fo`
vim.keymap.set("n", "<leader>fo", get_vscode_cmd("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"))

-- Find files using `<leader>ff`
vim.keymap.set("n", "<leader>ff", function()
    vim.api.nvim_call_function("VSCodeNotify", {
        "fzf.run"
    })
end)

-- Focus in liveshare to the side using `<leader>fc`
vim.keymap.set("n", "<leader>fc", get_vscode_cmd("liveshare.followToTheSide"))
