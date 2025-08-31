return {
  {
    "obsidian-nvim/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    cond = os.execute("test -d " .. os.getenv("HOME") .. "/Documents/Vault") == 0,
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
