local format_on_save = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
local autoformat_enabled = true

---@param bufnr number
local function is_null_ls_formatting_enabled(bufnr)
	local file_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
	local generators =
		require("null-ls.generators").get_available(file_type, require("null-ls.methods").internal.FORMATTING)
	return #generators > 0
end

---@param bufnr number
local function format(bufnr)
	vim.lsp.buf.format({
		---@param client lsp.Client
		filter = function(client)
			if is_null_ls_formatting_enabled(bufnr) then
				return client.name == "null-ls"
			end

			return true
		end,
	})
end

vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
	autoformat_enabled = not autoformat_enabled
	if autoformat_enabled then
		print("FormatOnSave turned on")
	else
		print("FormatOnSave turned off")
	end
end, {})

vim.api.nvim_create_user_command("Format", function()
	format(vim.api.nvim_win_get_buf(0))
end, {})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_on_save,
	callback = function(ev)
		if autoformat_enabled then
			format(ev.buf)
		end
	end,
})
