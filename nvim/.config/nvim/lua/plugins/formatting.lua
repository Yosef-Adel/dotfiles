return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters = {
        eslint_d = {
          timeout_ms = 5000,
        },
      },
      formatters_by_ft = {
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 5000,
        async = true,
      },
      -- format_after_save = {
      --   lsp_fallback = true,
      --   timeout_ms = 5000,
      --   async = false,
      -- },
    })
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        timeout_ms = 5000,
        async = false,
      })
    end)
  end,
}
