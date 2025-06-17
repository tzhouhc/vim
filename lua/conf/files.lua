-- For customizing special filetype associations that neovim does not guess
-- correctly by itself.
vim.filetype.add({
  extension = {
    nu = "nu",
  },
  filename = {
    ["justfile"] = "just",
    [".justfile"] = "just",
    [".notes"] = "markdown",
  },
})
