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
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
    -- Check if the filetype is 'help'
    if filetype == ft then
      return true
    end
  end
  -- Return false if no help buffers are found
  return false
end

function M.kill_all_win_of_filetype(ft)
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win.winid)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
    if filetype == ft then
      vim.api.nvim_win_close(win.winid, true)
    end
  end
end

-- Create a float at cursor location with the specified ft
function M.make_float(content, ft)
  vim.schedule(function()
    vim.lsp.util.open_floating_preview(
      content,
      ft,
      { border = "single", focusable = false, close_events = { "BufLeave", "CursorMoved", "InsertEnter" } }
    )
  end)
end

function M.make_float_from_cmd(cmd, ft)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- Remove empty lines at the end
        while #data > 0 and data[#data]:match("^%s*$") do
          table.remove(data)
        end
        if #data == 0 then
          data = { "No results." }
        end
        M.make_float(data, ft)
      end
    end,
  })
end

local function right_side_window(buf)
  -- Calculate popup dimensions and position
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * 0.4)
  local height = math.floor(ui.height * 0.9)
  local col = ui.width - width - 5
  local row = math.floor((ui.height - height) / 2)

  return vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "single",
    focusable = true,
    style = "minimal",
  })
end

function M.make_popup(content, ft)
  vim.schedule(function()
    -- Create a scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
    if ft then
      vim.api.nvim_set_option_value("filetype", ft, { buf = 0 })
    end

    local win = right_side_window(buf)
    -- Close window on <esc>
    vim.api.nvim_buf_set_keymap(
      buf,
      "n",
      "<esc>",
      string.format("<cmd>lua pcall(vim.api.nvim_win_close, %d, true)<CR>", win),
      { nowait = true, noremap = true, silent = true }
    )
  end)
end

function M.make_popup_from_cmd(cmd, ft)
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- Remove empty lines at the end
        while #data > 0 and data[#data]:match("^%s*$") do
          table.remove(data)
        end
        if #data == 0 then
          data = { "No results." }
        end
        M.make_popup(data, ft)
      end
    end,
  })
end

return M
