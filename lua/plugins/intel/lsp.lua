return {
	-- LSPs
	"neovim/nvim-lspconfig",
  -- pictograms for completion types
  { "onsails/lspkind.nvim", event = "LspAttach" },

  -- mason for managing installing lsp binaries.
  -- needed on start up to set PATH.
  {
    "williamboman/mason.nvim",
    config = true,
  },
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
