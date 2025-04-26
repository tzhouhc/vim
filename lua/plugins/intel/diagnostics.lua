return {
  -- diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = { "<leader>dg" },
    config = function()
      require("trouble").setup()
      local trouble_opts =
      "win.type=float win.position={0, -2} win.relative=editor win.border=rounded win.size={width=0.4,height=1}"
      vim.api.nvim_create_user_command("Diagnostics", "Trouble diagnostics toggle " .. trouble_opts, {})
      vim.keymap.set("n", "<leader>dg", "<cmd>Diagnostics<cr>")
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000,    -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
    end
  }
}
