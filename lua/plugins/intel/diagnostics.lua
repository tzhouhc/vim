return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
    end
  },
  {
    -- give a preview to the code actions to be applied
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "ibhagwan/fzf-lua" },
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
}
