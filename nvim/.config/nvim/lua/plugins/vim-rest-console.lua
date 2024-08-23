return {
	"diepm/vim-rest-console",
	config = function()
		-- Set the output buffer name and formatting options
		vim.g.vrc_output_buffer_name = "__OUTPUT.json"
		vim.g.vrc_auto_format_response_patterns = {
			json = "jq",
		}

		-- Disable the default mappings
		vim.g.vrc_set_default_mapping = 0

		-- Set custom mapping for executing the REST request
		vim.api.nvim_set_keymap("n", "<leader>xr", ":call VrcQuery()<CR>", { noremap = true, silent = true })
	end,
}
