return {
  {
    "numToStr/Comment.nvim",
    config = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
  {
    -- annotation / docstrings
    "danymat/neogen",
    cmd = { "Neogen" },
    config = true,
  }
}
