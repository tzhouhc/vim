return {
  {
    "yetone/avante.nvim",
    cmd = "AvanteAsk",
    build = "make",
    config = function()
      require("avante").setup({
        provider = "openrouter",
        vendors = {
          openrouter = {
            api_key_name = "OPENROUTER_API_KEY",
            endpoint = "https://openrouter.ai/api/v1/chat/completions",
            -- model = "anthropic/claude-3.5-sonnet",
            model = "deepseek/deepseek-chat",
            parse_curl_args = function(opts, code_opts)
              return {
                url = opts.endpoint,
                headers = {
                  ["Content-Type"] = "application/json",
                  ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
                },
                body = {
                  model = opts.model,
                  messages = require("avante.providers").openai.parse_messages(code_opts), -- you can make your own message, but this is very advanced
                  temperature = 0,
                  max_tokens = 4096,
                  stream = true,
                },
              }
            end,
            parse_response_data = function(data_stream, event_state, opts)
              require("avante.providers").openai.parse_response(data_stream, event_state, opts)
            end,
          },
        },
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-3.5-turbo",
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          max_tokens = 4096,
          ["local"] = false,
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
    "robitx/gp.nvim",
    config = function()
      local conf = {
        openai_api_key = {
          "/opt/homebrew/bin/age", "-d", "-i", vim.fn.expand("$HOME") .. "/.ssh/id_rsa",
          vim.fn.expand("$HOME") .. "/.credentials/openai_key"
        },
        default_command_agent = "gpt-4o-mini",
        default_chat_agent = "gpt-4o",
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
          {
            provider = "openai",
            name = "gpt-4o-mini",
            chat = false,
            command = true,
            model = { model = "gpt-4o-mini" },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "openai",
            name = "gpt-4o",
            chat = true,
            command = false,
            model = { model = "gpt-4o" },
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
          {
            provider = "ollama",
            name = "ollama-deepseek-r1-code",
            chat = false,
            command = true,
            model = { model = "deepseek-r1", stop = "<think></think>" },
            system_prompt = require("gp.defaults").code_system_prompt,
          },
          {
            provider = "ollama",
            name = "ollama-deepseek-r1-chat",
            chat = true,
            command = false,
            model = { model = "deepseek-r1", stop = "<think></think>" },
            system_prompt = require("gp.defaults").chat_system_prompt,
          },
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
