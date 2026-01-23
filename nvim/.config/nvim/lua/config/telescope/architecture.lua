-- Architecture Layer Searches for Clean Architecture monorepo
local M = {}

function M.setup(builtin, map)
	-- Search Interactors - FILES
	map("n", "<leader>si", function()
		builtin.find_files({
			prompt_title = "Find Interactor Files",
			find_command = { "fd", "--type", "f", "--glob", "*Interactor.ts", "packages" },
		})
	end, { desc = "[S]earch [I]nteractor Files" })

	-- Search Interactors - CONTENT
	map("n", "<leader>sI", function()
		builtin.live_grep({
			prompt_title = "Search in Interactors",
			glob_pattern = "**/interactors/*.ts",
		})
	end, { desc = "[S]earch in [I]nteractors (content)" })

	-- Search Stores - FILES
	map("n", "<leader>ss", function()
		builtin.find_files({
			prompt_title = "Find Store Files",
			find_command = { "fd", "--type", "f", "--glob", "*Store.ts", "packages" },
		})
	end, { desc = "[S]earch [S]tore Files" })

	-- Search Stores - CONTENT
	map("n", "<leader>sS", function()
		builtin.live_grep({
			prompt_title = "Search in Stores",
			glob_pattern = { "**/store/*.ts", "**/stores/*.ts" },
		})
	end, { desc = "[S]earch in [S]tores (content)" })

	-- Search Gateways - FILES
	map("n", "<leader>sg", function()
		builtin.find_files({
			prompt_title = "Find Gateway Files",
			find_command = { "fd", "--type", "f", "--glob", "*Gateway.ts", "packages/gateways" },
		})
	end, { desc = "[S]earch [G]ateway Files" })

	-- Search Gateways - CONTENT
	map("n", "<leader>sG", function()
		builtin.live_grep({
			prompt_title = "Search in Gateways",
			search_dirs = { "packages/gateways" },
		})
	end, { desc = "[S]earch in [G]ateways (content)" })

	-- Search Presenters - FILES
	map("n", "<leader>sp", function()
		builtin.find_files({
			prompt_title = "Find Presenter Files",
			find_command = {
				"fd",
				"--type",
				"f",
				"(Presenter|Container)",
				"packages",
				"--extension",
				"ts",
				"--extension",
				"tsx",
				"--exclude",
				"*DIContainer*",
			},
		})
	end, { desc = "[S]earch [P]resenter Files" })

	-- Search Presenters - CONTENT
	map("n", "<leader>sP", function()
		builtin.live_grep({
			prompt_title = "Search in Presenters",
			glob_pattern = { "**/presenters/*.ts*", "**/containers/*.ts*" },
		})
	end, { desc = "[S]earch in [P]resenters (content)" })

	-- Search Components - FILES
	map("n", "<leader>so", function()
		builtin.find_files({
			prompt_title = "Find Component Files",
			find_command = { "fd", "--type", "f", "--extension", "tsx", "components", "packages" },
		})
	end, { desc = "[S]earch C[o]mponent Files" })

	-- Search Components - CONTENT
	map("n", "<leader>sO", function()
		builtin.live_grep({
			prompt_title = "Search in Components",
			glob_pattern = "**/components/**/*.tsx",
		})
	end, { desc = "[S]earch in C[o]mponents (content)" })

	-- Search Entities - FILES
	map("n", "<leader>se", function()
		builtin.find_files({
			prompt_title = "Find Entity Files",
			find_command = { "fd", "--type", "f", "--full-path", "entities/.*\\.ts$", "packages/core" },
		})
	end, { desc = "[S]earch [E]ntity Files" })

	-- Search Abstract Tokens - FILES
	map("n", "<leader>sa", function()
		builtin.find_files({
			prompt_title = "Find Abstract Token Files",
			find_command = { "fd", "--type", "f", "--glob", "Abstract*.ts", "packages/core" },
		})
	end, { desc = "[S]earch [A]bstract Token Files" })

	-- Search Abstract Tokens - CONTENT
	map("n", "<leader>sA", function()
		builtin.live_grep({
			prompt_title = "Search in Abstract Tokens",
			glob_pattern = "**/types/Abstract*.ts",
		})
	end, { desc = "[S]earch in [A]bstract Tokens (content)" })

	-- Search DI Containers - FILES
	map("n", "<leader>sd", function()
		builtin.find_files({
			prompt_title = "Find DI Container Files",
			find_command = { "fd", "--type", "f", "--glob", "*DIContainer.ts", "packages" },
		})
	end, { desc = "[S]earch [D]I Container Files" })

	-- Search DI Containers - CONTENT
	map("n", "<leader>sD", function()
		builtin.live_grep({
			prompt_title = "Search in DI Containers",
			glob_pattern = "**/*DIContainer.ts",
		})
	end, { desc = "[S]earch in [D]I Containers (content)" })

	-- Search by Feature Domain
	map("n", "<leader>sF", function()
		builtin.find_files({
			prompt_title = "Browse Core Feature Domains",
			cwd = "packages/core",
			find_command = { "fd", "--type", "d", "--max-depth", "1" },
		})
	end, { desc = "[S]earch [F]eature Domains" })

	-- Search Core Package - FILES
	map("n", "<leader>sC", function()
		builtin.find_files({
			prompt_title = "Find Files in @moika/core",
			cwd = "packages/core",
		})
	end, { desc = "[S]earch [C]ore Package Files" })

	-- Search Core Package - CONTENT
	map("n", "<leader>sc", function()
		builtin.live_grep({
			prompt_title = "Search in @moika/core",
			search_dirs = { "packages/core" },
		})
	end, { desc = "[S]earch in [C]ore Package (content)" })

	-- Search Execute Methods
	map("n", "<leader>sx", function()
		builtin.live_grep({
			prompt_title = "Search Execute Methods",
			default_text = "execute(",
			glob_pattern = "**/interactors/*.ts",
		})
	end, { desc = "[S]earch E[x]ecute Methods" })

	-- Search Test Files - FILES
	map("n", "<leader>st", function()
		builtin.find_files({
			prompt_title = "Find Test Files",
			find_command = { "fd", "--type", "f", "--glob", "*.{spec,test}.ts", "packages" },
		})
	end, { desc = "[S]earch [T]est Files" })

	-- Search Test Files - CONTENT
	map("n", "<leader>sT", function()
		builtin.live_grep({
			prompt_title = "Search in Tests",
			glob_pattern = "**/*.{spec,test}.ts",
		})
	end, { desc = "[S]earch in [T]ests (content)" })

	-- Interactive Layer Selector
	map("n", "<leader>sl", function()
		M.open_layer_selector(builtin)
	end, { desc = "[S]earch by [L]ayer (menu)" })
end

function M.open_layer_selector(builtin)
	local layer_configs = {
		{ name = "Interactors (files)            <leader>si", key = "si", type = "files" },
		{ name = "Interactors (content)          <leader>sI", key = "sI", type = "content" },
		{ name = "Stores (files)                 <leader>ss", key = "ss", type = "files" },
		{ name = "Stores (content)               <leader>sS", key = "sS", type = "content" },
		{ name = "Gateways (files)               <leader>sg", key = "sg", type = "files" },
		{ name = "Gateways (content)             <leader>sG", key = "sG", type = "content" },
		{ name = "Presenters (files)             <leader>sp", key = "sp", type = "files" },
		{ name = "Presenters (content)           <leader>sP", key = "sP", type = "content" },
		{ name = "Components (files)             <leader>so", key = "so", type = "files" },
		{ name = "Components (content)           <leader>sO", key = "sO", type = "content" },
		{ name = "Entities (files)               <leader>se", key = "se", type = "files" },
		{ name = "Abstract Tokens (files)        <leader>sa", key = "sa", type = "files" },
		{ name = "Abstract Tokens (content)      <leader>sA", key = "sA", type = "content" },
		{ name = "DI Containers (files)          <leader>sd", key = "sd", type = "files" },
		{ name = "DI Containers (content)        <leader>sD", key = "sD", type = "content" },
		{ name = "Tests (files)                  <leader>st", key = "st", type = "files" },
		{ name = "Tests (content)                <leader>sT", key = "sT", type = "content" },
		{ name = "Core Package (files)           <leader>sC", key = "sC", type = "files" },
		{ name = "Core Package (content)         <leader>sc", key = "sc", type = "content" },
		{ name = "Feature Domains                <leader>sF", key = "sF", type = "files" },
		{ name = "Execute Methods                <leader>sx", key = "sx", type = "content" },
	}

	local actions = {
		si = function()
			builtin.find_files({
				prompt_title = "Find Interactor Files",
				find_command = { "fd", "--type", "f", "--glob", "*Interactor.ts", "packages" },
			})
		end,
		sI = function()
			builtin.live_grep({ prompt_title = "Search in Interactors", glob_pattern = "**/interactors/*.ts" })
		end,
		ss = function()
			builtin.find_files({
				prompt_title = "Find Store Files",
				find_command = { "fd", "--type", "f", "--glob", "*Store.ts", "packages" },
			})
		end,
		sS = function()
			builtin.live_grep({
				prompt_title = "Search in Stores",
				glob_pattern = { "**/store/*.ts", "**/stores/*.ts" },
			})
		end,
		sg = function()
			builtin.find_files({
				prompt_title = "Find Gateway Files",
				find_command = { "fd", "--type", "f", "--glob", "*Gateway.ts", "packages/gateways" },
			})
		end,
		sG = function()
			builtin.live_grep({ prompt_title = "Search in Gateways", search_dirs = { "packages/gateways" } })
		end,
		sp = function()
			builtin.find_files({
				prompt_title = "Find Presenter Files",
				find_command = {
					"fd",
					"--type",
					"f",
					"(Presenter|Container)",
					"packages",
					"--extension",
					"ts",
					"--extension",
					"tsx",
					"--exclude",
					"*DIContainer*",
				},
			})
		end,
		sP = function()
			builtin.live_grep({
				prompt_title = "Search in Presenters",
				glob_pattern = { "**/presenters/*.ts*", "**/containers/*.ts*" },
			})
		end,
		so = function()
			builtin.find_files({
				prompt_title = "Find Component Files",
				find_command = { "fd", "--type", "f", "--extension", "tsx", "components", "packages" },
			})
		end,
		sO = function()
			builtin.live_grep({ prompt_title = "Search in Components", glob_pattern = "**/components/**/*.tsx" })
		end,
		se = function()
			builtin.find_files({
				prompt_title = "Find Entity Files",
				find_command = { "fd", "--type", "f", "--full-path", "entities/.*\\.ts$", "packages/core" },
			})
		end,
		sa = function()
			builtin.find_files({
				prompt_title = "Find Abstract Token Files",
				find_command = { "fd", "--type", "f", "--glob", "Abstract*.ts", "packages/core" },
			})
		end,
		sA = function()
			builtin.live_grep({ prompt_title = "Search in Abstract Tokens", glob_pattern = "**/types/Abstract*.ts" })
		end,
		sd = function()
			builtin.find_files({
				prompt_title = "Find DI Container Files",
				find_command = { "fd", "--type", "f", "--glob", "*DIContainer.ts", "packages" },
			})
		end,
		sD = function()
			builtin.live_grep({ prompt_title = "Search in DI Containers", glob_pattern = "**/*DIContainer.ts" })
		end,
		st = function()
			builtin.find_files({
				prompt_title = "Find Test Files",
				find_command = { "fd", "--type", "f", "--glob", "*.{spec,test}.ts", "packages" },
			})
		end,
		sT = function()
			builtin.live_grep({ prompt_title = "Search in Tests", glob_pattern = "**/*.{spec,test}.ts" })
		end,
		sC = function()
			builtin.find_files({ prompt_title = "Find Files in @moika/core", cwd = "packages/core" })
		end,
		sc = function()
			builtin.live_grep({ prompt_title = "Search in @moika/core", search_dirs = { "packages/core" } })
		end,
		sF = function()
			builtin.find_files({
				prompt_title = "Browse Core Feature Domains",
				cwd = "packages/core",
				find_command = { "fd", "--type", "d", "--max-depth", "1" },
			})
		end,
		sx = function()
			builtin.live_grep({
				prompt_title = "Search Execute Methods",
				default_text = "execute(",
				glob_pattern = "**/interactors/*.ts",
			})
		end,
	}

	local choices = vim.tbl_map(function(item)
		return item.name
	end, layer_configs)

	vim.ui.select(choices, { prompt = "Select Layer to Search:" }, function(_, idx)
		if not idx then
			return
		end
		local key = layer_configs[idx].key
		if actions[key] then
			actions[key]()
		end
	end)
end

return M
