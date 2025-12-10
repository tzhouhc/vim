return {
  {
    "numToStr/Comment.nvim",
    config = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
  {
    -- annotation / docstrings
    "danymat/neogen",
    keys = { "<leader>ng" },
    cmd = { "Neogen" },
    config = function()
      require("neogen").setup()
      vim.keymap.set("n", "<leader>ng", "<cmd>Neogen<cr>", {})
    end,
  },
}
