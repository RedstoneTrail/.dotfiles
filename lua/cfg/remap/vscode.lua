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

-- Focus in liveshare to the side using `<leader>fsh`
vim.keymap.set("n", "<leader>fsh", get_vscode_cmd("liveshare.followToTheSide"))

-- Focus terminal using `<leader>t`
vim.keymap.set("n", "<leader>t", get_vscode_cmd("terminal.focus"))

-- Goto symbol using `<leader>sy`
vim.keymap.set("n", "<leader>sy", get_vscode_cmd("workbench.action.gotoSymbol"))

-- Hide panels using `<leader>h`
vim.keymap.set("n", "<leader>h", function()
    call_vscode_cmd("workbench.action.closeSidebar")
    call_vscode_cmd("workbench.action.closePanel")
end)
