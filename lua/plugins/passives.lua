return {
  -- passives
  -- automatically close/add pairs
  { "windwp/nvim-autopairs",  config = true },
  -- y/d/s for pairs at once
  { "kylechui/nvim-surround", config = true },
  -- removing trailing whitespace on save
  "bronson/vim-trailing-whitespace",
  -- kill buffer but keep split
  "qpkorr/vim-bufkill",
  -- follow symlinks
  "aymericbeaumet/vim-symlink",
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "d",
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
