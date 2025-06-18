return {
  {
    "jackMort/ChatGPT.nvim",
    keys = { "<leader>cc" },
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions", "ExplainCode" },
    config = function()
      require("chatgpt").setup({
        openai_params = {
          -- NOTE: model can be a function returning the model name
          model = "gpt-4o-mini",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        }
      })

      vim.keymap.set("v", "<leader>cc", "<cmd>ChatGPTRun complete_code<cr>",
        { noremap = true, silent = true })
      vim.api.nvim_create_user_command("ExplainCode", function()
        vim.cmd("ChatGPTRun explain_code")
      end, { range = true })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
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
