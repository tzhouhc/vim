return {
  -- visuals
  -- better default selection tools
  { "stevearc/dressing.nvim" },

  -- highlight TODOs
  { "folke/todo-comments.nvim", config = true },
  -- keep top of code context on screen when scrolling past
  "nvim-treesitter/nvim-treesitter-context",
  -- smarter folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function(_, ft, _)
        if ft == "python" then
          return { "indent" }
        end
        return { "treesitter", "indent" }
      end,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
      },
    },
  },
  -- navic
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = true,
  },
}
