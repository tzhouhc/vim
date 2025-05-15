local M = {}

function M.is_win_open_with_type(t)
  -- Get the list of all window IDs
  local windows = vim.api.nvim_list_wins()
  -- Iterate through each window
  for _, win in ipairs(windows) do
    -- Get the buffer ID associated with the window
    local buf = vim.api.nvim_win_get_buf(win)
    -- Get the filetype of the buffer
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
    -- Check if the filetype is 'help'
    if filetype == t then
      return true
    end
  end
  -- Return false if no help buffers are found
  return false
end

return M
