return {
	"ThePrimeagen/refactoring.nvim",
	event = "VeryLazy",
	dependencies = {
		-- required since the plugin's async rewrite; without it `require("async")`
		-- silently resolves to promise-async and every refactor throws
		"lewis6991/async.nvim",
	},
	config = function()
		require("refactoring").setup({
			show_success_message = true,
		})

		local map = vim.keymap.set

		-- Every refactor below is operator-pending: the mapping returns the
		-- operator and you follow it with a motion/textobject (or use it from
		-- visual mode), hence `expr = true`.
		map({ "n", "x" }, "<leader>re", function()
			return require("refactoring").extract_func()
		end, { expr = true, desc = "Refactor: Extract function" })

		map({ "n", "x" }, "<leader>rf", function()
			return require("refactoring").extract_func_to_file()
		end, { expr = true, desc = "Refactor: Extract function to file" })

		map({ "n", "x" }, "<leader>rv", function()
			return require("refactoring").extract_var()
		end, { expr = true, desc = "Refactor: Extract variable" })

		map({ "n", "x" }, "<leader>ri", function()
			return require("refactoring").inline_var()
		end, { expr = true, desc = "Refactor: Inline variable" })

		map({ "n", "x" }, "<leader>rI", function()
			return require("refactoring").inline_func()
		end, { expr = true, desc = "Refactor: Inline function" })

		map({ "n", "x" }, "<leader>rx", function()
			require("refactoring").select_refactor()
		end, { desc = "Refactor: Select refactor" })

		-- Debug prints. In normal mode `iw` picks the word under the cursor;
		-- from visual mode the selection is used as-is.
		map("n", "<leader>rp", function()
			return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
		end, { expr = true, desc = "Refactor: Print variable below" })

		map("x", "<leader>rp", function()
			return require("refactoring.debug").print_var({ output_location = "below" })
		end, { expr = true, desc = "Refactor: Print variable below" })

		map({ "n", "x" }, "<leader>rc", function()
			return require("refactoring.debug").cleanup({ restore_view = true })
		end, { expr = true, remap = true, desc = "Refactor: Clean up debug prints" })
	end,
}
