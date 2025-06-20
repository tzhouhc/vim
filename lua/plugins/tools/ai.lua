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
    },
    config = function()
      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              layout = "float",
              position = "right",
            }
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
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
