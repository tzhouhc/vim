-- Utilities handling neovim's windows.

local M = {}

---check for windows with specific key properties, e.g. "quickfix"
---@param type string
---@return boolean
function M.has_win_of_type(type)
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win[type] == 1 then
      return true
    end
  end
  return false
end

---check for windows with specific filetype, e.g. "help"
---@param ft string
---@return boolean
function M.has_win_of_filetype(ft)
  -- Get the list of all window IDs
  local windows = vim.api.nvim_list_wins()
  -- Iterate through each window
  for _, win in ipairs(windows) do
    -- Get the buffer ID associated with the window
    local buf = vim.api.nvim_win_get_buf(win)
    -- Get the filetype of the buffer
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
    -- Check if the filetype is 'help'
    if filetype == ft then
      return true
    end
  end
  -- Return false if no help buffers are found
  return false
end

return M
