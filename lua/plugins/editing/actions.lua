return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {"ibhagwan/fzf-lua"},
    },
    event = "LspAttach",
    opts = {},
    config = function()
      local tca = require("tiny-code-action")
      tca.setup({
        backend = "delta",
        picker = "select",
      })
      vim.keymap.set("n", "<leader>ca", function()
        require("tiny-code-action").code_action()
      end, { noremap = true, silent = true })
    end
  },
  {
    -- quickly expand or compactify a dict/list/set/...
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = true,
  }
}
