if not vim.g.vscode then
	local lualine = require("lualine")

	lualine.setup({
		options = {
			theme = "catppuccin"
		}
	})

	vim.cmd([[
		augroup lualine_augroup
        		autocmd!
			autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
		augroup END
	]])
end
