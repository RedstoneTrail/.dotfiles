vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50

require("cfg.remap")

vim.cmd("colorscheme onedark")

if not vim.g.vscode then
	vim.opt.nu = true
	vim.opt.relativenumber = true

	local lualine = require("lualine")
	require("lsp-progress").setup()

	lualine.setup({
		sections = {
			lualine_c = {
				require("lsp-progress").progress
			}
		}
	})

	vim.cmd([[
		augroup lualine_augroup
        		autocmd!
			autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
		augroup END
	]])
end
