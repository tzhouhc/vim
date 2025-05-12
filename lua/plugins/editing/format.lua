return {
  {
    "stevearc/conform.nvim",
    lazy = true,
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          c = { "clangd" },
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
