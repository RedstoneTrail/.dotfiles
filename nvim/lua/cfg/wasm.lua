vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.wasm",
	callback = function(ev)
		if vim.bo[ev.buf].buftype ~= "" then
			return
		end

		vim.bo[ev.buf].buftype = "nofile"
		vim.bo[ev.buf].filetype = "wat"

		---@type string[]
		local lines = {}
		for line in vim.fn.system({ "wasm-dis", vim.fn.bufname(ev.buf) }):gmatch("([^\n]+)") do
			table.insert(lines, line)
		end

		vim.api.nvim_buf_set_lines(ev.buf, 0, -1, true, lines)
		vim.bo[ev.buf].modifiable = false
	end,
})
