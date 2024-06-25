return {
  {
    "huggingface/llm.nvim",
    cmd = "LLMSuggestion",
    opts = {
      api_token = nil,                  -- cf Install paragraph
      model = "codellama:7b-code",      -- the model ID, behavior depends on backend
      backend = "ollama",               -- backend ID, "huggingface" | "ollama" | "openai" | "tgi"
      url = "http://localhost:11434",   -- the http url of the backend
      tokens_to_clear = { "<EOT>" },    -- tokens to remove from the model's output

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
        cmd_env = nil,   -- or { LLM_LOG_LEVEL = "DEBUG" } to set the log level of llm-ls
        version = "0.5.3",
      },
      tokenizer = {
        repository = "codellama/CodeLlama-13b-hf",
      },                                     -- cf Tokenizer paragraph
      context_window = 4096,                 -- max number of tokens for the context window
      enable_suggestions_on_startup = false,
      enable_suggestions_on_files = "*",     -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
      disable_url_path_completion = false,   -- cf Backend
    }
  },
}
