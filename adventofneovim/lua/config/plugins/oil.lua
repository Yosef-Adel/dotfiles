return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
	["<C-h>"] = false,
	["<C-p>"] = false,
	["<M-h>"] = "actions.select_split",
      },
      view_options = {
	show_hidden = true,
      },
    })

    -- Open parent directory in floating window
    vim.keymap.set("n", "<Leader>e", ":Oil<CR>", { silent = true, noremap = true })
  end,
}

