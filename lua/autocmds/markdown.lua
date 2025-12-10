vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*custom_phrase.txt", -- Replace with your desired filename
  callback = function()
    vim.bo.filetype = "tsv" -- Replace with your desired filetype
    vim.bo.expandtab = false
    vim.bo.tabstop = 8
    vim.bo.shiftwidth = 8
  end,
})
