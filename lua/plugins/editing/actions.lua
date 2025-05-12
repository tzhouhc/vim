-- high level logic:
-- <space> would be used to make these sort of edits that are slightlys
-- sophisticated to do manually but also not quite as trivial as can be done
-- using regular keystrokes.

return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        -- optional picker via fzf-lua
        {"ibhagwan/fzf-lua"},
    },
    event = "LspAttach",
    config = function()
      local tca = require("tiny-code-action")
      tca.setup({
        picker = "select",
      })
      vim.keymap.set("n", "<leader>ca", function()
	tca.code_action()
      end, { noremap = true, silent = true })
    end,
  },
}
