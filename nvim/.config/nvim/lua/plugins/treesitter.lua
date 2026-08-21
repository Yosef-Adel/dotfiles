return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- "master" is archived upstream; queries no longer match current parsers
		lazy = false, -- main branch does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			local parsers = {
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
				"markdown_inline",
				"vim",
				-- DevOps
				"dockerfile",
				"terraform",
				"hcl",
				"groovy", -- Jenkinsfile
			}
			require("nvim-treesitter").install(parsers)

			local max_filesize = 100 * 1024 -- 100 KB
			local function too_big(buf)
				local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
				return ok and stats and stats.size > max_filesize
			end

			-- lua/markdown/help/query already get vim.treesitter.start() from
			-- Neovim's own bundled ftplugins; everything else needs it enabled here
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"go",
					"javascript",
					"typescript",
					"typescriptreact",
					"css",
					"html",
					"yaml",
					"json",
					"sh",
					"bash",
					"vim",
					"dockerfile",
					"terraform",
					"hcl",
					"groovy",
				},
				callback = function(args)
					if too_big(args.buf) then
						return
					end
					vim.treesitter.start()
				end,
			})
		end,
	},
}
