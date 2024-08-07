return {
  -- highlight same token as the cursor is currently hovering over
  "RRethy/vim-illuminate",

  -- highlights certain patterns
  { "folke/paint.nvim",
    cond = false,
    opts = {
      highlights = {
        {
          -- filter = { filetype = "lua" },
          -- pattern = "folke",
          -- hl = "Constant",
        },
      },
    }
  },
}
