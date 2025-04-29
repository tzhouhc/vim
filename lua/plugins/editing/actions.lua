return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- optional picker via telescope
      { "nvim-telescope/telescope.nvim" },
    },
    event = "LspAttach",
    opts = {},
    config = function()
      local tca = require("tiny-code-action")
      tca.setup({
        backend = "delta",
        picker = "telescope",
      })
      vim.keymap.set("n", "<leader>ca", function()
        require("tiny-code-action").code_action()
      end, { noremap = true, silent = true })
    end
  },
}
