return {
	"michaelb/sniprun",
	build = "sh install.sh",
	config = function()
		require("sniprun").setup({
			display = {
				"Terminal",
			},
			display_options = {
				terminal_scrollback = vim.o.scrollback,
				terminal_line_number = false,
				terminal_signcolumn = false,
				terminal_position = "vertical",
				terminal_width = 50,
				terminal_height = 20,
			},
			selected_interpreters = { "JS_TS_deno" },
			interpreter_options = {
				JS_TS_deno = {
					use_on_filetypes = { "javascript", "typescript" }, -- Override default
				},
			},
			repl_enable = { "JS_TS_deno" }, -- Enable REPL for persistent state
		})
	end,
}
