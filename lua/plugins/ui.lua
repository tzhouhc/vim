return {
  -- visuals
  -- startup page
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  -- better default selection tools
  { "stevearc/dressing.nvim" },

  -- highlight TODOs
  { "folke/todo-comments.nvim", config = true },
  -- keep top of code context on screen when scrolling past
  "nvim-treesitter/nvim-treesitter-context",
  -- text objects
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- smarter folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
  },
  -- navic
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = true,
  },
  -- status bar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "meuter/lualine-so-fancy.nvim" },
  },
}
