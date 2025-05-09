return {
  {
    -- quickly expand or compactify a dict/list/set/...
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = true,
  },
  {
    -- quickly move an argument / node left or right
    "mizlan/iswap.nvim",
    event = { "BufNewFile", "BufReadPost", "BufWritePre" },
    config = function()
      require("iswap").setup({})

      vim.keymap.set({ 'n', 'v' }, "g>", "<cmd>ISwapWithRight<cr>", {})
      vim.keymap.set({ 'n', 'v' }, "g<", "<cmd>ISwapWithLeft<cr>", {})
      vim.keymap.set('n', "<leader>sw", "<cmd>ISwap<cr>", {})
    end
  }
}
