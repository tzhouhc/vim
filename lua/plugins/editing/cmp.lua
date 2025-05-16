local events = { "BufReadPost", "BufNewFile", "BufWritePre" }

return {
  -- completions
  { "hrsh7th/nvim-cmp",          event = events },
  { "hrsh7th/cmp-cmdline",       event = events },
  { "hrsh7th/cmp-buffer",        event = events },
  { "hrsh7th/cmp-calc",          event = events },
  { "hrsh7th/cmp-nvim-lsp",      event = events },
  { "hrsh7th/cmp-path",          event = events },
  { "PhilippFeO/cmp-help-tags",  event = events },
  { "xzbdmw/colorful-menu.nvim", event = events },
}
