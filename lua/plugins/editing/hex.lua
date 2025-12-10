return {
  {
    "RaafatTurki/hex.nvim",
    config = function()
      local hex = require("hex")
      hex.setup()
      vim.api.nvim_create_user_command("Hex", hex.toggle, {})
    end,
    cmd = { "Hex" },
  },
}
