return {
	"fatih/vim-go",
	ft = "go",
	build = ":GoUpdateBinaries",
	init = function()
		-- gopls is started by Neovim's own LSP client (see lsp-config.lua);
		-- without this vim-go spins up a second, redundant gopls per session
		vim.g.go_gopls_enabled = 0
		vim.g.go_def_mode = "godef"
		vim.g.go_info_mode = "godef"
	end,
}
