return {
  -- pictograms for completion types
  { "onsails/lspkind.nvim", event = "LspAttach" },

  -- by itself mason is fairly lightweight to start. mason-lspconfig, however,
  -- takes about 30ms.

  -- navic
  {
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      lsp = {
        auto_attach = true,
      }
    },
    config = true,
  },
}
