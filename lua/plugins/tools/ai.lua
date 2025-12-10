return {
  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    keys = {
      { "cc", mode = "ca" },
      { "ccc", mode = "ca" },
      { "<leader>cc" },
    },
    config = function()
      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              layout = "float",
              position = "right",
            },
          },
        },
        strategies = {
          chat = {
            adapter = "openai",
          },
          inline = {
            adapter = "openai",
          },
        },
      })
      vim.keymap.set("ca", "cc", "CodeCompanion", { noremap = true, silent = true })
      vim.keymap.set("ca", "ccc", "CodeCompanionChat", { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
