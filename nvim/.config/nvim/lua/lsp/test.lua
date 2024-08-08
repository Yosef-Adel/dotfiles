local client = vim.lsp.start_client({
	name = "educationalsp",
	cmd = { "/Users/yosefsaaid/dev/educationalsp/main" },
})

if not client then
	vim.notify("LSP not installed")
	return
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.lsp.buf_attach_client(0, client)
	end,
})
