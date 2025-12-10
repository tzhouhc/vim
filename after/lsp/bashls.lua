require("lspconfig").bashls.setup({
  settings = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh", "zsh" }, -- Ensure .zsh files are included
  },
})
