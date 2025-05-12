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
  -- code actions and preview
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },

      -- optional picker via telescope
      { "nvim-telescope/telescope.nvim" },
      -- optional picker via fzf-lua
      { "ibhagwan/fzf-lua" },
      -- .. or via snacks
      {
        "folke/snacks.nvim",
        opts = {
          terminal = {},
        }
      }
    },
    event = "LspAttach",
    config = function()
      local tca = require("tiny-code-action")
      tca.setup({})
      vim.keymap.set("n", "<leader>ca", function()
        tca.code_action()
      end, { noremap = true, silent = true })
    end,
  },
}
