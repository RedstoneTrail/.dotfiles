local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
local autosave_enabled = true

vim.api.nvim_create_user_command("AutosaveToggle", function()
	autosave_enabled = not autosave_enabled
	if autosave_enabled then
		print("Autosave turned on")
	else
		print("Autosave turned off")
	end
end, {})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_on_save,
	callback = function(ev)
		if autosave_enabled then
			vim.lsp.buf.format({ bufnr = ev.buf })
		end
	end,
})
