return {
  -- motion
  -- text targets like "inside quotes"
  "wellle/targets.vim",
  -- % to jump to matching "pair"
  { "andymass/vim-matchup", keys = { "%", "n" } },
  -- overall better movement methods
  { "folke/flash.nvim",     opts = { modes = { search = { enabled = false } } } },
}
