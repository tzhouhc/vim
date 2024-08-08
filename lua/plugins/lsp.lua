return {
  -- LSPs
  { "williamboman/mason.nvim", cmd = "Mason" },
  "williamboman/mason-lspconfig.nvim",
  "rafamadriz/friendly-snippets",
  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "nvimtools/none-ls.nvim",

  -- completions
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-calc",
  "hrsh7th/cmp-emoji",
  "chrisgrieser/cmp-nerdfont",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-path",
  "PhilippFeO/cmp-help-tags",

  -- symbol analysis
  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  }
}
