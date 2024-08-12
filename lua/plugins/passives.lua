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
  -- follow symlinks
  "aymericbeaumet/vim-symlink",
  -- don't yank deletion except with 'd'
  {
    "gbprod/cutlass.nvim",
    opts = {
      cut_key = "d",
    },
  },
}
