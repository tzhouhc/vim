vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = "if_many",
    scope = "line",
    border = "rounded",
  },
  underline = true,
  severity_sort = { reverse = true },
})

vim.o.updatetime = 500
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function ()
    vim.diagnostic.open_float(nil, {focus=false})
  end
})
