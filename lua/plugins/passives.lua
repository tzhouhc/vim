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
  -- helps remembering things like registers
  { "folke/which-key.nvim",   config = true },
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "d",
    },
  },
  -- automated ctagging
  "ludovicchabant/vim-gutentags",
  -- automatically switch IME for Chinese
  { "laishulu/vim-macos-ime", ft = { "text", "markdown" } },
  -- highlights certain patterns
  { "folke/paint.nvim",       ft = { "markdown" } },
}
