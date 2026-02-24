return {
	-- DAP UI: visual panels for variables, stack, breakpoints
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require("dapui")
			dapui.setup()
			-- Auto-open/close UI when debug session starts/ends
			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = function()
			vim.schedule(function() dapui.open() end)
		end
			dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
			dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
		end,
	},

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
