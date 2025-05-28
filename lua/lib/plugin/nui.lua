local Popup = require("nui.popup")
local win = require("lib.windows")

local M = {}

function M.static_info_popup()
  if vim.g.info_popup then
    return _G.info_popup
  end

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
  _G.info_popup = popup
  popup:map('n', '<esc>', function()
    popup:hide()
  end)
  popup:map('n', '<enter>', '<c-]>')
  popup:map('c', 'bd', 'bw')
  popup:mount()
  vim.api.nvim_set_current_win(popup.winid)
  vim.opt_local.buftype = "help"
  return popup
end

---create a nui popup and open the help topic in it.
---@param t any
function M.info_popup_wrapper(cmd, ft, t)
  -- do not create new popup window if one already exists
  if win.has_win_of_filetype(ft) then
    vim.fn.execute(cmd .. " " .. t.args)
    return
  end

  M.static_info_popup()  -- handles focusing
  -- this is the smart bit: help will open in existing windows that are of the
  -- help type!
  vim.opt_local.filetype = ft
  vim.fn.execute(cmd .. " " .. t.args)
end

function M.help_popup(t)
  return M.info_popup_wrapper("help", "help", t)
end

function M.man_popup(t)
  return M.info_popup_wrapper("Man", "man", t)
end

function M.toggle_info_popup()
  local popup = _G.info_popup or M.static_info_popup()
  if popup.winid then
    popup:hide()
  else
    popup:show()
  end
end

return M
