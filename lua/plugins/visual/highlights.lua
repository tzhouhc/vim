return {
  -- highlight same token as the cursor is currently hovering over
  {"RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile", "BufWritePre" } },

  -- highlight words under cursor
  {
    "Mr-LLLLL/interestingwords.nvim",
    keys = { { "<leader>k", "n" }, { "<leader>m", "n" } },
    opts = {
      colors = { '#8fbcbb', '#88c0d0', '#bf616a', '#d08770', '#ebcb8b', '#a3be8c' },
      search_count = true,
      navigation = true,
      scroll_center = false,
      search_key = "<leader>m",
      cancel_search_key = "<leader>M",
      color_key = "<leader>k",
      cancel_color_key = "<leader>K",
      select_mode = "random", -- random or loop
    }
  },
}
