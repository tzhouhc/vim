local Popup = require("nui.popup")
local Layout = require("nui.layout")
local event = require("nui.utils.autocmd").event

local M = {}

-- Function to check if any window has a buffer with the filetype "help"
local function is_help_buffer_open()
    -- Get the list of all window IDs
    local windows = vim.api.nvim_list_wins()
    -- Iterate through each window
    for _, win in ipairs(windows) do
        -- Get the buffer ID associated with the window
        local buf = vim.api.nvim_win_get_buf(win)
        -- Get the filetype of the buffer
        local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
        -- Check if the filetype is 'help'
        if filetype == 'help' then
            return true
        end
    end
    -- Return false if no help buffers are found
    return false
end

---create a nui popup and open the help topic in it.
---@param t any
function M.help_popup(t)
  -- do not create new popup window if one already exists
  if is_help_buffer_open() then
    vim.fn.execute("help " .. t.args)
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
  vim.opt_local.filetype = "help"
  vim.opt_local.buftype = "help"
  vim.fn.execute("help " .. t.args)
end

return M
