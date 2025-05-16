return {
  "rafamadriz/friendly-snippets",
  {
    "chrisgrieser/nvim-scissors",
    cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
    dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
    opts = {
      snippetDir = os.getenv("VIM_HOME") .. "/snippets",
    },
  },
}
