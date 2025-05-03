return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "Refactor" },
    config = function()
      require("refactoring").setup()
    end,
  },
  {
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
