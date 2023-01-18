vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50

require("cfg.remap")

if not vim.g.vscode then
    vim.cmd([[ colorscheme onedark  ]])
    vim.opt.nu = true
    vim.opt.relativenumber = true

    local lualine = require("lualine")
    lualine.setup()
end
