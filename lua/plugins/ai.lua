return {
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        openai_api_key = {
          "/opt/homebrew/bin/age", "-d", "-i", vim.fn.expand("$HOME") .. "/.ssh/id_rsa",
          vim.fn.expand("$HOME") .. "/.credentials/openai_key"
        },
        providers = {
          -- NOTE:
          -- OpenRouter has wildly unstable first-token latencies, so
          -- it's probably unfit for local edit usage.
          openrouter = {
            endpoint = "https://openrouter.ai/api/v1/chat/completions",
            secret = os.getenv("OPENROUTER_API_KEY"),
          },
          ollama = {
            endpoint = "http://localhost:11434/v1/chat/completions",
            secret = "dummy_secret",
          },
        },
        agents = {
        }
      }
      require("gp").setup(conf)
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
    config = function()
      require("chatgpt").setup({
        -- this config assumes you have OPENAI_API_KEY environment variable set
        api_key_cmd = "/opt/homebrew/bin/age -d -i " .. vim.fn.expand("$HOME") .. "/.ssh/id_rsa " ..
            vim.fn.expand("$HOME") .. "/.credentials/openai_key",
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
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
}
