if vim.g.theme ~= nil then
  vim.cmd("colorscheme " .. vim.g.theme)
else
  vim.cmd("colorscheme nord")
end
