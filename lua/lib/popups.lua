local Popup = require("nui.popup")
local win = require("lib.windows")

local M = {}

---create a nui popup and open the help topic in it.
---@param t any
function M.info_popup_wrapper(cmd, ft, t)
  -- do not create new popup window if one already exists
  if win.is_win_open_with_type(ft) then
    vim.fn.execute(cmd .. " " .. t.args)
    return
  end

  -- create a new popup on the right side
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
  vim.opt_local.filetype = ft
  vim.opt_local.buftype = "help"
  vim.fn.execute(cmd .. " " .. t.args)
end

function M.help_popup(t)
  return M.info_popup_wrapper("help", "help", t)
end

function M.man_popup(t)
  return M.info_popup_wrapper("Man", "man", t)
end

return M
