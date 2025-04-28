return {
  -- motion
  -- text targets like "inside quotes"
  {
    "wellle/targets.vim",
    event = "BufEnter",
  },
  -- % to jump to matching "pair"
  { "andymass/vim-matchup", keys = { "%", "n" } },
  -- overall better movement methods
  {
    "folke/flash.nvim",
    event = "BufEnter",
    config = function()
      local f = require("flash")
      f.setup({ modes = { search = { enabled = false } } })
      -- ctrl/meta+j to select and go to one specific letter on screen
      vim.keymap.set("n", "<c-j>", f.jump)
      vim.keymap.set("n", "<m-j>", f.jump)
    end
  },
}
