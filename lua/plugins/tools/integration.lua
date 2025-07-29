return {
  {
    "obsidian-nvim/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Vault",
        },
      },
    },
  }
}
