local api = vim.api
local fn = vim.fn

-- automatically update working dir when entering buffer.
api.nvim_create_augroup("WorkingDirectory", { clear = true })
api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*.*"},
  callback = function()
    local path = fn.expand('%:h')..'/'
    path = "cd "..path
    api.nvim_command(path)
  end,
  group = "WorkingDirectory",
})
