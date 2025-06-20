return {
  -- highlight same token as the cursor is currently hovering over
  {
    "RRethy/vim-illuminate",
    cond = not not vim.g.highlight_word_under_cursor,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },

  -- highlight words under cursor
  {
    "Mr-LLLLL/interestingwords.nvim",
    cmd = { "HighlightWord" },
    keys = { "?" },
    config = function()
      local iw = require("interestingwords")
      iw.setup({
        colors = { '#8fbcbb', '#88c0d0', '#bf616a', '#d08770', '#ebcb8b', '#a3be8c' },
        search_count = true,
        navigation = true,
        scroll_center = false,
        search_key = nil,
        cancel_search_key = nil,
        color_key = "<leader>k",
        cancel_color_key = "<leader><esc>",
        select_mode = "random", -- random or loop
      })

      -- I don't really ever search backwards, so we use `?` as
      -- "higlight + search", and it also does the normal + visual combined
      -- thing.
      vim.keymap.set('n', "?", function()
        iw.InterestingWord('n', false)
        iw.InterestingWord('n', true)
      end, { noremap = true, silent = true, desc = "InterestingWord Toggle Search" })
      vim.keymap.set('x', "?", function()
        iw.InterestingWord('v', false)
        iw.InterestingWord('v', true)
      end, { noremap = true, silent = true, desc = "InterestingWord Toggle Search" })
    end,
  },
}
