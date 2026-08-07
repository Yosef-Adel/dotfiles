return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			treesitter.setup({
				auto_install = true,
				ensure_installed = {
					"go",
					"javascript",
					"typescript",
					"tsx",
					"css",
					"html",
					"yaml",
					"json",
					"lua",
					"bash",
					"markdown",
					"vim",
				},
				highlight = {
					enable = true,
					disable = function(lang, buf)
						-- markdown's bundled highlight query uses the conceal_lines
						-- directive on fenced code block delimiters, which crashes
						-- on Neovim 0.12 (nvim-treesitter#8618, closed not-planned)
						if lang == "markdown" then
							return true
						end

						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				additional_vim_regex_highlighting = { "markdown" },
			})
		end,
	},
}
