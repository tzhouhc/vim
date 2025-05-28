return {
  {
    "MunifTanjim/nui.nvim",
    config = function()
      local popups = require("lib.popups")
      -- keymap set globally so that it also takes effect *inside* the popups
      vim.keymap.set("n", "<leader>pp", popups.toggle_info_popup, {})
    end
  },
}
