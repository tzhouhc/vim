return {
  {
    "yetone/avante.nvim",
    cmd = "AvanteAsk",
    build = "make",
    config = function()
      require("avante").setup({
        provider = "deepseek",
        vendors = {
          openrouter = {
            api_key_name = "OPENROUTER_API_KEY",
            endpoint = "https://openrouter.ai/api/v1/chat/completions",
            -- model = "anthropic/claude-3.5-sonnet",
            model = "deepseek/deepseek-chat",
            __inherited_from = "openai",
          },
          openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-3.5-turbo",
            timeout = 30000, -- Timeout in milliseconds
            temperature = 0,
            max_tokens = 4096,
            ["local"] = false,
          },
          deepseek = {
            api_key_name = "DEEPSEEK_API_KEY",
            endpoint = "https://api.deepseek.com",
            model = "deepseek-reasoner",
            __inherited_from = "openai",
          },
        },
      })
    end,
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end,  desc = "avante: ask",  mode = { "n", "v" } },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v" },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "MeanderingProgrammer/render-markdown.nvim",
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
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
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
}
