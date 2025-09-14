return {
  {
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
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- ensure devicons
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle file tree" },
      { "<leader>T", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal in file tree" },
    },
    opts = {
      -- Oil is the directory hijacker
      disable_netrw = true,
      hijack_netrw = false,
      hijack_directories = { enable = false },

      sync_root_with_cwd = true,
      update_focused_file = { enable = true, update_root = false },

      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = "", info = "", warning = "", error = "" },
      },

      view = { width = 36 },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },

        icons = {
          webdev_colors = true, -- use devicons colors
          git_placement = "before",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },

      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
    },
  },
}
