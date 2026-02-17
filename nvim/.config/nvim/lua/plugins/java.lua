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
		opts = {},
	},
}
