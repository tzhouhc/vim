-- high level logic:
-- <space> would be used to make these sort of edits that are slightlys
-- sophisticated to do manually but also not quite as trivial as can be done
-- using regular keystrokes.

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

      vim.keymap.set({ 'n', 'v' }, "<space><right>", "<cmd>ISwapWithRight<cr>", {})
      vim.keymap.set({ 'n', 'v' }, "<space><left>", "<cmd>ISwapWithLeft<cr>", {})
      vim.keymap.set('n', "<space>sw", "<cmd>ISwap<cr>", {})
    end
  }
}
