return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettier" },
          sql = { "sql_formatter" },
          markdown = { "prettier" },
        },
        default_format_opts = {
          lsp_format = "prefer",
        },
      })
      conform.formatters.black = {
        prepend_args = { "--line-length", "80" },
      }
    end,
  },
}
