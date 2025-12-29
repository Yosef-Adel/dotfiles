return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		-- Fold settings
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- Keymaps for folding
		vim.keymap.set("n", "+", require("ufo").openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "-", require("ufo").closeAllFolds, { desc = "Close all folds" })

		-- Setup UFO with LSP and indent providers
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "lsp", "indent" }
			end,
		})
	end,
}
