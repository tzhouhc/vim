return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      local ps = require("persistence")
      ps.setup({
        -- add any custom options here
        branch = false,
      })
      vim.api.nvim_create_user_command("SelectSession", function()
        ps.select()
      end, {})
      vim.api.nvim_create_user_command("SessionLoadLast", function()
        ps.load({ last = true })
      end, {})
      vim.api.nvim_create_user_command("SessionLoadHere", function()
        ps.load()
      end, {})
    end,
  }
}
