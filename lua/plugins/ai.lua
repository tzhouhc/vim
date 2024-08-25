local local_llm_plugin =
{
  "huggingface/llm.nvim",
  cmd = "LLMSuggestion",
  opts = {
    api_token = nil,                -- cf Install paragraph
    model = "codellama:7b-code",    -- the model ID, behavior depends on backend
    backend = "ollama",             -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
    url = "http://localhost:11434", -- the http url of the backend
    tokens_to_clear = { "<EOT>" },  -- tokens to remove from the model's output

    -- parameters that are added to the request body, values are arbitrary, you can set any field:value pair here it will be passed as is to the backend
    request_body = {
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },

    -- set this if the model supports fill in the middle
    fim = {
      enabled = true,
      -- NOTE: the spaces are important
      prefix = "<PRE> ",
      middle = " <MID> ",
      suffix = " <SUF>",
    },
    debounce_ms = 150,
    accept_keymap = "<S-Tab>",
    dismiss_keymap = "<m-q>",

    tls_skip_verify_insecure = false,
    -- llm-ls configuration, cf llm-ls section
    lsp = {
      bin_path = nil,
      host = nil,
      port = nil,
      cmd_env = nil, -- or { LLM_LOG_LEVEL = "DEBUG" } to set the log level of llm-ls
      version = "0.5.3",
    },
    tokenizer = {
      repository = "codellama/CodeLlama-13b-hf",
    },                                   -- cf Tokenizer paragraph
    context_window = 4096,               -- max number of tokens for the context window
    enable_suggestions_on_startup = false,
    enable_suggestions_on_files = "*",   -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
    disable_url_path_completion = false, -- cf Backend
  }
}

return {
  -- { "David-Kunz/gen.nvim" },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-3.5-turbo",
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
        ["local"] = false,
      },
      -- add any opts here
    },
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end,     desc = "avante: ask",    mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
      { "<leader>ae", function() require("avante.api").edit() end,    desc = "avante: edit",   mode = "v" },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- Make sure to setup it properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
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
          -- this is useful if you want to change the model on the fly
          -- using commands
          -- Example:
          -- model = function()
          --     if some_condition() then
          --         return "gpt-4-1106-preview"
          --     else
          --         return "gpt-3.5-turbo"
          --     end
          -- end,
          model = "gpt-3.5-turbo",
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
