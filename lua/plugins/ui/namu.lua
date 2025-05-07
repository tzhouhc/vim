return {
  {
    "bassamsdata/namu.nvim",
		event = "LspAttach",
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {
            row_position = ""
          }, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = false }, -- vim.ui.select() wrapper
      })

      vim.api.nvim_create_user_command("Symbols", "Namu symbols", {})
      vim.api.nvim_create_user_command("WorkspaceSymbols", "Namu workspace", {})
      vim.api.nvim_create_user_command("Watchtower", "Namu watchtower", {})
      vim.api.nvim_create_user_command("Callsites", "Namu call in", {})
      vim.api.nvim_create_user_command("Invokes", "Namu call out", {})

      vim.keymap.set("n", "<leader>wt", "<cmd>Watchtower<cr>")
    end,
  }
}
