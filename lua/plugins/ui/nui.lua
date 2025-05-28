local popups = require("lib.popups")

return {
  {
    "MunifTanjim/nui.nvim",
    config = function()
      vim.keymap.set("n", "<leader>pp", popups.toggle_info_popup, {})
      -- Custom Help popup
      vim.api.nvim_create_user_command("H", popups.help_popup, { nargs = "?", complete = "help" })
      vim.keymap.set("ca", "h", "H", { noremap = true, silent = true })
      vim.api.nvim_create_user_command("M", popups.man_popup, { nargs = "?" })
    end
  },
}
