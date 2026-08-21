return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "" },
			topdelete = { text = "" },
			changedelete = { text = "▎" },
			untracked = { text = "▎" },
		},
		current_line_blame_opts = {
			delay = 300,
			virt_text_pos = "eol",
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation. Falls through to plain ]c / [c when a diff is open.
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, "Next git hunk")

			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, "Previous git hunk")

			map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage selected hunk")
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset selected hunk")
			map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
			map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end, "Blame line")
			map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
			map("n", "<leader>gd", gs.diffthis, "Diff this")
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, "Diff against last commit")
			map("n", "<leader>gq", gs.setqflist, "Hunks to quickfix")

			map({ "o", "x" }, "ih", gs.select_hunk, "Select git hunk")
		end,
	},
}
