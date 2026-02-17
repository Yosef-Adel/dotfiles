return {
	-- nvim-jdtls: Java LSP with extended capabilities
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
	},

	-- Spring Boot language server support
	{
		"JavaHello/spring-boot.nvim",
		ft = { "java", "yaml", "jproperties" },
		dependencies = {
			"mfussenegger/nvim-jdtls",
		},
		opts = function()
			-- ls_path must be the exec JAR, not the directory (spring-boot.nvim runs: java -jar ls_path)
			local xdg_data = vim.env.XDG_DATA_HOME or (vim.env.HOME .. "/.local/share")
			local ls_dir = xdg_data .. "/spring-boot-ls/language-server"
			local jar = vim.fn.glob(ls_dir .. "/*-exec.jar")
			if jar ~= "" then
				return { ls_path = jar }
			end
			return {}
		end,
	},
}
