local group = vim.api.nvim_create_augroup("NeoJoey_Event_Group", { clear = true })

vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#6EACDA", fg = "#021526" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.hl.on_yank({
			higroup = "YankHighlight",
			timeout = 200,
		})
	end,
	group = group,
})

-- Warn when entering or writing a file inside node_modules
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
	desc = "Notify if the buffer is within node_modules",
	callback = function(args)
		if not vim.api.nvim_buf_get_name(args.buf):find("node_modules", 1, true) then
			return
		end
		local level = args.event == "BufWritePre" and vim.log.levels.ERROR or vim.log.levels.WARN
		local verb = args.event == "BufWritePre" and "are writing to" or "entered"
		vim.schedule(function()
			vim.notify(("Warning: You %s a file in node_modules!"):format(verb), level, {
				title = "Node Modules Warning",
			})
		end)
	end,
	group = group,
})

-- Enable spell checking only for prose filetypes
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable spell checking for prose filetypes",
	pattern = { "markdown", "text", "gitcommit", "html" },
	callback = function()
		vim.opt_local.spell = true
	end,
	group = group,
})

-- Jenkinsfiles are Groovy DSL; there's no viable completion LSP for the
-- Jenkins pipeline DSL, but this at least gets treesitter highlighting
vim.filetype.add({
	filename = {
		["Jenkinsfile"] = "groovy",
		[".gitlab-ci.yml"] = "yaml.gitlab", -- gitlab_ci_ls only attaches to this compound filetype
	},
	pattern = {
		[".*%.Jenkinsfile"] = "groovy",
		["Jenkinsfile%..*"] = "groovy",
		[".*%.gitlab%-ci%.yml"] = "yaml.gitlab", -- included/child CI files
	},
})
