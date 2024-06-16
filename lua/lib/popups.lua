local Popup = require("nui.popup")
local Layout = require("nui.layout")
local event = require("nui.utils.autocmd").event

local M = {}

---create a nui popup and open the help topic in it.
---@param t any
function M.help_popup(t)
  print(t.args)
  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "single",
    },
    position = {
      row = "5%",
      col = "95%"
    },
    size = {
      width = "40%",
      height = "95%",
    },
  })
  -- mount/open the component
  popup:mount()
  popup:map('n', '<esc>', function()
    vim.api.nvim_win_close(0, true)
  end)
  popup:map('n', '<enter>', '<c-]>')
  popup:map('c', 'bd', 'bw')
  vim.api.nvim_set_current_win(popup.winid)
  -- this is the smart bit: help will open in existing windows that are of the
  -- help type!
  vim.opt_local.filetype = "help"
  vim.opt_local.buftype = "help"
  -- vim.api.nvim_set_current_buf(popup.bufnr)
  vim.fn.execute("help " .. t.args)
end

return M
