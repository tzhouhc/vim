local events = { "BufReadPost", "BufNewFile", "BufWritePre" }

return {
  -- completions
  {
    "saghen/blink.cmp",
    event = events,
    config = true,
    opts = {
      keymap = {
        ['<Tab>'] = {
          'select_next',
          'snippet_forward',
          'fallback'
        },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
      }
    }
  },
  {
    "saghen/blink.compat",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    event = events,
    opts = {
      sources = {
        -- remember to enable your providers here
        default = { 'lsp', 'vsnip', 'buffer', 'path' },
      },
    }
  },
}
