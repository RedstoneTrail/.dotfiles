vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

require("cfg.remap")

if not vim.g.vscode then
    vim.cmd([[
        set clipboard=unnamedplus
        set nu rnu
        colorscheme onedark
    ]])
    require("lualine").setup()
end
