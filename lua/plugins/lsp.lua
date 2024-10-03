return {
  -- LSPs
  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",

  -- mason
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  "williamboman/mason-lspconfig.nvim",
  -- null-ls
  {
    "nvimtools/none-ls.nvim",
    cond = false,
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent_type=Spaces", "--indent_width=2" },
          }),
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.black,
          -- null_ls.builtins.completion.spell,
          null_ls.builtins.hover.dictionary,
          null_ls.builtins.hover.printenv.with({
            extra_filetypes = { "zsh" },
          }),
        },
      })
    end,
  },

  -- symbol analysis
  {
    'stevearc/aerial.nvim',
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    cmd = { "AerialPrev", "AerialNext", "AerialToggle" },
    opts = {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    },
  }
}
