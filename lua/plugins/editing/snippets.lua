return {
  "rafamadriz/friendly-snippets",
  {
    "chrisgrieser/nvim-scissors",
    cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
    dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
    opts = {
      snippetDir = vim.fs.joinpath(vim.g.vim_home, "snippets"),
    },
  },
}
