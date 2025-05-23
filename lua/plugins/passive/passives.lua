local events = { "BufReadPost", "BufNewFile", "BufWritePre" }
return {
  -- passives
  -- automatically close/add pairs
  {
    "windwp/nvim-autopairs",
    config = true,
    event = events,
  },
  -- y/d/s for pairs at once
  {
    "kylechui/nvim-surround",
    config = true,
    event = events,
  },
  -- removing trailing whitespace on save
  {
    "bronson/vim-trailing-whitespace",
    event = events,
  },
  -- kill buffer but keep split
  {
    "qpkorr/vim-bufkill",
    cond = not not vim.g.keep_win_after_bufkill,
    event = events,
  },
  -- follow symlinks
  "aymericbeaumet/vim-symlink",
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    cond = not not vim.g.no_yank_deletion,
    opts = {
      cut_key = "d",
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cond = not not vim.g.enable_which_key,
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
  },
  -- handle big files
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 2,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = {       -- features to disable
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    }
  },
}
