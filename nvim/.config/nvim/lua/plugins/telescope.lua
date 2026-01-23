return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
					},
					file_ignore_patterns = {
						"node_modules/.*",
						"%.git/.*",
						"%.next/.*",
						"dist/.*",
						"build/.*",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set

			-- Core Telescope searches (preserved from original)
			map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp Tags" })
			map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>sb", builtin.builtin, { desc = "[S]earch [B]uiltin Telescope" })
			map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			map("n", "<leader>sz", builtin.diagnostics, { desc = "[S]earch Diagnosti[z]s" })
			map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			map("n", "<leader>sm", builtin.marks, { desc = " Find marks buffers" })
			map("n", "<leader>sj", builtin.jumplist, { desc = " Find jumplist" })
			map("n", "<C-p>", builtin.find_files, { desc = "[P]roject [F]iles" })
			map("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "[P]roject [S]earch" })
			map("n", "<leader>f", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			map("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			map("n", "<leader>sN", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim config files" })
			map("n", "<leader>sn", function()
				builtin.find_files({ cwd = "~/Documents/Second Brain/" })
			end, { desc = "[S]earch [N]otes" })

			-- ========================================
			-- Architecture Layer Search Patterns
			-- ========================================

			-- Search Interactors - FILES (find by filename)
			map("n", "<leader>si", function()
				builtin.find_files({
					prompt_title = "🎯 Find Interactor Files",
					find_command = { "fd", "--type", "f", "--glob", "*Interactor.ts", "packages" },
				})
			end, { desc = "[S]earch [I]nteractor Files" })

			-- Search Interactors - CONTENT (search code inside)
			map("n", "<leader>sI", function()
				builtin.live_grep({
					prompt_title = "🎯 Search in Interactors",
					glob_pattern = "**/interactors/*.ts",
				})
			end, { desc = "[S]earch in [I]nteractors (content)" })

			-- Search Stores - FILES
			map("n", "<leader>ss", function()
				builtin.find_files({
					prompt_title = "💾 Find Store Files",
					find_command = { "fd", "--type", "f", "--glob", "*Store.ts", "packages" },
				})
			end, { desc = "[S]earch [S]tore Files" })

			-- Search Stores - CONTENT (both store/ and stores/ directories)
			map("n", "<leader>sS", function()
				builtin.live_grep({
					prompt_title = "💾 Search in Stores",
					glob_pattern = { "**/store/*.ts", "**/stores/*.ts" },
				})
			end, { desc = "[S]earch in [S]tores (content)" })

			-- Search Gateways - FILES
			map("n", "<leader>sg", function()
				builtin.find_files({
					prompt_title = "🌐 Find Gateway Files",
					find_command = { "fd", "--type", "f", "--glob", "*Gateway.ts", "packages/gateways" },
				})
			end, { desc = "[S]earch [G]ateway Files" })

			-- Search Gateways - CONTENT
			map("n", "<leader>sG", function()
				builtin.live_grep({
					prompt_title = "🌐 Search in Gateways",
					search_dirs = { "packages/gateways" },
				})
			end, { desc = "[S]earch in [G]ateways (content)" })

			-- Search Presenters - FILES (both .ts and .tsx, includes legacy containers)
			map("n", "<leader>sp", function()
				builtin.find_files({
					prompt_title = "🎨 Find Presenter Files",
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

			-- Search Presenters - CONTENT (both .ts and .tsx, includes containers)
			map("n", "<leader>sP", function()
				builtin.live_grep({
					prompt_title = "🎨 Search in Presenters",
					glob_pattern = { "**/presenters/*.ts*", "**/containers/*.ts*" },
				})
			end, { desc = "[S]earch in [P]resenters (content)" })

			-- Search Components - FILES
			map("n", "<leader>so", function()
				builtin.find_files({
					prompt_title = "🧩 Find Component Files",
					find_command = { "fd", "--type", "f", "--extension", "tsx", "components", "packages" },
				})
			end, { desc = "[S]earch C[o]mponent Files" })

			-- Search Components - CONTENT
			map("n", "<leader>sO", function()
				builtin.live_grep({
					prompt_title = "🧩 Search in Components",
					glob_pattern = "**/components/**/*.tsx",
				})
			end, { desc = "[S]earch in C[o]mponents (content)" })

			-- Search Entities - FILES
			map("n", "<leader>se", function()
				builtin.find_files({
					prompt_title = "📦 Find Entity Files",
					find_command = { "fd", "--type", "f", "--full-path", "entities/.*\\.ts$", "packages/core" },
				})
			end, { desc = "[S]earch [E]ntity Files" })

			-- Search Abstract Tokens - FILES
			map("n", "<leader>sa", function()
				builtin.find_files({
					prompt_title = "🔗 Find Abstract Token Files",
					find_command = { "fd", "--type", "f", "--glob", "Abstract*.ts", "packages/core" },
				})
			end, { desc = "[S]earch [A]bstract Token Files" })

			-- Search Abstract Tokens - CONTENT
			map("n", "<leader>sA", function()
				builtin.live_grep({
					prompt_title = "🔗 Search in Abstract Tokens",
					glob_pattern = "**/types/Abstract*.ts",
				})
			end, { desc = "[S]earch in [A]bstract Tokens (content)" })

			-- Search DI Containers - FILES
			map("n", "<leader>sd", function()
				builtin.find_files({
					prompt_title = "🏗️  Find DI Container Files",
					find_command = { "fd", "--type", "f", "--glob", "*DIContainer.ts", "packages" },
				})
			end, { desc = "[S]earch [D]I Container Files" })

			-- Search DI Containers - CONTENT
			map("n", "<leader>sD", function()
				builtin.live_grep({
					prompt_title = "🏗️  Search in DI Containers",
					glob_pattern = "**/*DIContainer.ts",
				})
			end, { desc = "[S]earch in [D]I Containers (content)" })

			-- Search by Feature Domain (packages/core/<domain>)
			map("n", "<leader>sF", function()
				builtin.find_files({
					prompt_title = "🎯 Browse Core Feature Domains",
					cwd = "packages/core",
					find_command = { "fd", "--type", "d", "--max-depth", "1" },
				})
			end, { desc = "[S]earch [F]eature Domains" })

			-- Search Core Package - ALL FILES
			map("n", "<leader>sC", function()
				builtin.find_files({
					prompt_title = "⚡ Find Files in @moika/core",
					cwd = "packages/core",
				})
			end, { desc = "[S]earch [C]ore Package Files" })

			-- Search Core Package - CONTENT
			map("n", "<leader>sc", function()
				builtin.live_grep({
					prompt_title = "⚡ Search in @moika/core",
					search_dirs = { "packages/core" },
				})
			end, { desc = "[S]earch in [C]ore Package (content)" })

			-- Search Execute Methods (all interactor entry points)
			map("n", "<leader>sx", function()
				builtin.live_grep({
					prompt_title = "▶️  Search Execute Methods",
					default_text = "execute(",
					glob_pattern = "**/interactors/*.ts",
				})
			end, { desc = "[S]earch E[x]ecute Methods" })

			-- Search Test Files - FILES
			map("n", "<leader>st", function()
				builtin.find_files({
					prompt_title = "🧪 Find Test Files",
					find_command = { "fd", "--type", "f", "--glob", "*.{spec,test}.ts", "packages" },
				})
			end, { desc = "[S]earch [T]est Files" })

			-- Search Test Files - CONTENT
			map("n", "<leader>sT", function()
				builtin.live_grep({
					prompt_title = "🧪 Search in Tests",
					glob_pattern = "**/*.{spec,test}.ts",
				})
			end, { desc = "[S]earch in [T]ests (content)" })

			-- Interactive Layer Selector (quick menu for all layers)
			map("n", "<leader>sl", function()
				local layer_configs = {
					{
						name = "Interactors (files)            <leader>si",
						action = function()
							builtin.find_files({
								prompt_title = "🎯 Find Interactor Files",
								find_command = { "fd", "--type", "f", "--glob", "*Interactor.ts", "packages" },
							})
						end,
					},
					{
						name = "Interactors (content)          <leader>sI",
						action = function()
							builtin.live_grep({
								prompt_title = "🎯 Search in Interactors",
								glob_pattern = "**/interactors/*.ts",
							})
						end,
					},
					{
						name = "Stores (files)                 <leader>ss",
						action = function()
							builtin.find_files({
								prompt_title = "💾 Find Store Files",
								find_command = { "fd", "--type", "f", "--glob", "*Store.ts", "packages" },
							})
						end,
					},
					{
						name = "Stores (content)               <leader>sS",
						action = function()
							builtin.live_grep({
								prompt_title = "💾 Search in Stores",
								glob_pattern = { "**/store/*.ts", "**/stores/*.ts" },
							})
						end,
					},
					{
						name = "Gateways (files)               <leader>sg",
						action = function()
							builtin.find_files({
								prompt_title = "🌐 Find Gateway Files",
								find_command = { "fd", "--type", "f", "--glob", "*Gateway.ts", "packages/gateways" },
							})
						end,
					},
					{
						name = "Gateways (content)             <leader>sG",
						action = function()
							builtin.live_grep({
								prompt_title = "🌐 Search in Gateways",
								search_dirs = { "packages/gateways" },
							})
						end,
					},
					{
						name = "Presenters (files)             <leader>sp",
						action = function()
							builtin.find_files({
								prompt_title = "🎨 Find Presenter Files",
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
					},
					{
						name = "Presenters (content)           <leader>sP",
						action = function()
							builtin.live_grep({
								prompt_title = "🎨 Search in Presenters",
								glob_pattern = { "**/presenters/*.ts*", "**/containers/*.ts*" },
							})
						end,
					},
					{
						name = "Components (files)             <leader>so",
						action = function()
							builtin.find_files({
								prompt_title = "🧩 Find Component Files",
								find_command = { "fd", "--type", "f", "--extension", "tsx", "components", "packages" },
							})
						end,
					},
					{
						name = "Components (content)           <leader>sO",
						action = function()
							builtin.live_grep({
								prompt_title = "🧩 Search in Components",
								glob_pattern = "**/components/**/*.tsx",
							})
						end,
					},
					{
						name = "Entities (files)               <leader>se",
						action = function()
							builtin.find_files({
								prompt_title = "📦 Find Entity Files",
								find_command = { "fd", "--type", "f", ".", "entities", "--extension", "ts", "packages/core" },
							})
						end,
					},
					{
						name = "Abstract Tokens (files)        <leader>sa",
						action = function()
							builtin.find_files({
								prompt_title = "🔗 Find Abstract Token Files",
								find_command = { "fd", "--type", "f", "--glob", "Abstract*.ts", "packages/core" },
							})
						end,
					},
					{
						name = "Abstract Tokens (content)      <leader>sA",
						action = function()
							builtin.live_grep({
								prompt_title = "🔗 Search in Abstract Tokens",
								glob_pattern = "**/types/Abstract*.ts",
							})
						end,
					},
					{
						name = "DI Containers (files)          <leader>sd",
						action = function()
							builtin.find_files({
								prompt_title = "🏗️  Find DI Container Files",
								find_command = { "fd", "--type", "f", "--glob", "*DIContainer.ts", "packages" },
							})
						end,
					},
					{
						name = "DI Containers (content)        <leader>sD",
						action = function()
							builtin.live_grep({
								prompt_title = "🏗️  Search in DI Containers",
								glob_pattern = "**/*DIContainer.ts",
							})
						end,
					},
					{
						name = "Tests (files)                  <leader>st",
						action = function()
							builtin.find_files({
								prompt_title = "🧪 Find Test Files",
								find_command = { "fd", "--type", "f", "--glob", "*.{spec,test}.ts", "packages" },
							})
						end,
					},
					{
						name = "Tests (content)                <leader>sT",
						action = function()
							builtin.live_grep({
								prompt_title = "🧪 Search in Tests",
								glob_pattern = "**/*.{spec,test}.ts",
							})
						end,
					},
					{
						name = "Core Package (files)           <leader>sC",
						action = function()
							builtin.find_files({
								prompt_title = "⚡ Find Files in @moika/core",
								cwd = "packages/core",
							})
						end,
					},
					{
						name = "Core Package (content)         <leader>sc",
						action = function()
							builtin.live_grep({
								prompt_title = "⚡ Search in @moika/core",
								search_dirs = { "packages/core" },
							})
						end,
					},
					{
						name = "Feature Domains                <leader>sF",
						action = function()
							builtin.find_files({
								prompt_title = "🎯 Browse Core Feature Domains",
								cwd = "packages/core",
								find_command = { "fd", "--type", "d", "--max-depth", "1" },
							})
						end,
					},
					{
						name = "Execute Methods                <leader>sx",
						action = function()
							builtin.live_grep({
								prompt_title = "▶️  Search Execute Methods",
								default_text = "execute(",
								glob_pattern = "**/interactors/*.ts",
							})
						end,
					},
				}

				local choices = vim.tbl_map(function(item)
					return item.name
				end, layer_configs)

				vim.ui.select(choices, {
					prompt = "Select Layer to Search:",
				}, function(choice, idx)
					if not choice then
						return
					end
					-- Execute the selected search action
					layer_configs[idx].action()
				end)
			end, { desc = "[S]earch by [L]ayer (menu)" })
		end,
	},
}
