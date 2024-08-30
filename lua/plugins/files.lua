return {
  {
    -- editing filesystem like a buffer
    "stevearc/oil.nvim",
    opts = {},
    config = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
  },
  -- file explorer
  {
    "mikavilpas/yazi.nvim",
    config = true,
    cmd = { "Yazi" },
  }
}
