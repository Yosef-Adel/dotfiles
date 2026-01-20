return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup({
			-- Control prompts for function signatures
			prompt_func_return_type = {
				go = false,
				cpp = false,
				c = false,
				java = false,
			},
			prompt_func_param_type = {
				go = false,
				cpp = false,
				c = false,
				java = false,
			},
			show_success_message = true,
		})

		local refactor = require("refactoring")

		-- === VISUAL MODE ===
		-- Extract selection into a function
		vim.keymap.set("x", "<leader>re", function()
			refactor.refactor("Extract Function")
		end, { desc = "Refactor: Extract function" })

		-- Extract selection into a function in a separate file
		vim.keymap.set("x", "<leader>rf", function()
			refactor.refactor("Extract Function To File")
		end, { desc = "Refactor: Extract to file" })

		-- === NORMAL MODE ===
		-- Inline variable, debug helpers, cleanup, etc.
		vim.keymap.set("n", "<leader>ri", function()
			refactor.refactor("Inline Variable")
		end, { desc = "Refactor: Inline variable" })

		vim.keymap.set("n", "<leader>rp", function()
			refactor.debug.printf({ below = false })
		end, { desc = "Refactor: Add debug print" })

		-- vim.keymap.set("n", "<leader>rc", function()
		-- 	refactor.debug.cleanup({})
		-- end, { desc = "Refactor: Cleanup debug statements" })

		-- Optional: auto-reload treesitter queries when updating
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*/refactoring.lua",
			callback = function()
				require("nvim-treesitter.query").invalidate_all()
			end,
		})
	end,
}
