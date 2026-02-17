local jdtls = require("jdtls")

-- Use Mason's known install path for jdtls
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

if vim.fn.isdirectory(jdtls_path) == 0 then
	vim.notify("jdtls is not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
	return
end

-- Find root of java project
-- Prefer .git/mvnw/gradlew over pom.xml so multi-module Maven projects use the
-- repo root instead of stopping at the nearest submodule pom.xml
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })
	or require("jdtls.setup").find_root({ "pom.xml", "build.gradle" })

-- Workspace directory (unique per project)
local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local os_config = "mac"
if vim.fn.has("linux") == 1 then
	os_config = "linux"
elseif vim.fn.has("win32") == 1 then
	os_config = "win"
end

-- Gather debug/test bundles
local bundles = {}

-- java-debug-adapter
local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local debug_path = mason_path .. "/java-debug-adapter"
if vim.fn.isdirectory(debug_path) == 1 then
	local debug_jars = vim.fn.glob(debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
	vim.list_extend(bundles, debug_jars)
end

-- java-test
local test_path = mason_path .. "/java-test"
if vim.fn.isdirectory(test_path) == 1 then
	local test_jars = vim.tbl_filter(function(jar)
		-- runner-jar and jacocoagent are not OSGi bundles and cause "Failed to get bundleInfo" errors
		return not jar:match("runner%-jar%-with%-dependencies") and not jar:match("jacocoagent")
	end, vim.fn.glob(test_path .. "/extension/server/*.jar", true, true))
	vim.list_extend(bundles, test_jars)
end

-- Spring Boot extensions
local spring_ok, spring_boot = pcall(require, "spring_boot")
if spring_ok then
	-- Try spring-boot.nvim's built-in discovery (Mason, VSCode extensions)
	local spring_jars = spring_boot.java_extensions()
	if #spring_jars == 0 then
		-- Fallback: check our custom install path from setup-java-nvim script
		local xdg_data = vim.env.XDG_DATA_HOME or (vim.env.HOME .. "/.local/share")
		local custom_jars_path = xdg_data .. "/spring-boot-ls/jars"
		if vim.fn.isdirectory(custom_jars_path) == 1 then
			spring_jars = spring_boot.java_extensions(custom_jars_path)
		end
	end
	vim.list_extend(bundles, spring_jars)
end

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. jdtls_path .. "/lombok.jar",
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/config_" .. os_config,
		"-data",
		workspace_dir,
	},

	root_dir = root_dir,

	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			configuration = {
				runtimes = (function()
					local runtimes = {}
					local sdkman_java = vim.fn.expand("~/.sdkman/candidates/java")
					if vim.fn.isdirectory(sdkman_java) == 1 then
						-- Discover installed Java versions from SDKMAN
						local dirs = vim.fn.globpath(sdkman_java, "*", true, true)
						for _, dir in ipairs(dirs) do
							local name = vim.fn.fnamemodify(dir, ":t")
							if name ~= "current" and vim.fn.isdirectory(dir .. "/bin") == 1 then
								-- Extract major version number
								local major = name:match("^(%d+)")
								if major then
									table.insert(runtimes, {
										name = "JavaSE-" .. major,
										path = dir,
									})
								end
							end
						end
					end
					-- Mark the first one as default, prefer Java 21
					table.sort(runtimes, function(a, b)
						local a_num = tonumber(a.name:match("%d+")) or 0
						local b_num = tonumber(b.name:match("%d+")) or 0
						-- Put 21 first, then sort ascending
						if a_num == 21 then return true end
						if b_num == 21 then return false end
						return a_num < b_num
					end)
					if #runtimes > 0 then
						runtimes[1].default = true
					end
					return runtimes
				end)(),
			},
		},
	},

	init_options = {
		bundles = bundles,
	},

	capabilities = (function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}
		return capabilities
	end)(),

	on_attach = function(_, bufnr)
		local opts = { buffer = bufnr, silent = true }

		vim.keymap.set("n", "<leader>co", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
		vim.keymap.set("n", "<leader>cv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
		vim.keymap.set("v", "<leader>cv", function() jdtls.extract_variable(true) end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
		vim.keymap.set("n", "<leader>cc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
		vim.keymap.set("v", "<leader>cc", function() jdtls.extract_constant(true) end, vim.tbl_extend("force", opts, { desc = "Extract constant" }))
		vim.keymap.set("v", "<leader>cm", function() jdtls.extract_method(true) end, vim.tbl_extend("force", opts, { desc = "Extract method" }))

		vim.keymap.set("n", "<leader>jt", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test class" }))
		vim.keymap.set("n", "<leader>jn", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test nearest method" }))

		pcall(jdtls.setup_dap, { hotcodereplace = "auto" })
	end,
}

jdtls.start_or_attach(config)
