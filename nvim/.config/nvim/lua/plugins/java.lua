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
			-- Check custom install path from setup-java-nvim script
			local xdg_data = vim.env.XDG_DATA_HOME or (vim.env.HOME .. "/.local/share")
			local custom_ls = xdg_data .. "/spring-boot-ls/language-server"
			if vim.fn.isdirectory(custom_ls) == 1 then
				return { ls_path = custom_ls }
			end
			return {}
		end,
	},
}
