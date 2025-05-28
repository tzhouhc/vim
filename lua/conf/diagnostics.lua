vim.diagnostic.config({
  -- Other diagnostic settings you might want to adjust
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = { reverse = true },
})

vim.o.updatetime = 500

