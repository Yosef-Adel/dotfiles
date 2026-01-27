return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local jdtls = require("jdtls")
		local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
		local java_home = os.getenv("JAVA_HOME") or vim.fn.expand("~/.sdkman/candidates/java/current")
		local java_bin = java_home .. "/bin/java"

		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

		local config = {
			cmd = {
				java_bin,
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
				"-configuration",
				jdtls_path .. "/config_mac",
				"-data",
				workspace_dir,
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
			settings = {
				java = {
					signatureHelp = { enabled = true },
					completion = {
						favoriteStaticMembers = {
							"org.junit.jupiter.api.Assertions.*",
							"org.mockito.Mockito.*",
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
				},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				jdtls.start_or_attach(config)
			end,
		})
	end,
}
