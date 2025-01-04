return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- https://github.com/folke/snacks.nvim?tab=readme-ov-file#-features
      -- for more components to enable

      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      -- dashboard = { enabled = true },
      indent = {
        enabled = true,
        char = "┆",
        only_scope = true, -- only show indent guides of the scope
        only_current = true,
        indent = {
          hl = {
            "RainbowDarkDelim1",
            "RainbowDarkDelim2",
            "RainbowDarkDelim3",
            "RainbowDarkDelim4",
            "RainbowDarkDelim5",
            "RainbowDarkDelim6",
            "RainbowDarkDelim7",
            "RainbowDarkDelim8",
            "RainbowDarkDelim9",
            "RainbowDarkDelim10",
            "RainbowDarkDelim11",
            "RainbowDarkDelim12",
          }
        },
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "linear",
          duration = {
            step = 10,
            total = 200,
          }
        },
        scope = {
          char = "┆",
          hl = {
            "RainbowDelim1",
            "RainbowDelim2",
            "RainbowDelim3",
            "RainbowDelim4",
            "RainbowDelim5",
            "RainbowDelim6",
            "RainbowDelim7",
            "RainbowDelim8",
            "RainbowDelim9",
            "RainbowDelim10",
            "RainbowDelim11",
            "RainbowDelim12",
          }
        }
      },
      input = { enabled = true },
      -- notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
  }
}
