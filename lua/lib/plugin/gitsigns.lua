local gitsigns = require("gitsigns")
local M = {}

function M.prev_hunk()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gitsigns.nav_hunk('prev')
  end
end

function M.next_hunk()
  if vim.wo.diff then
    vim.cmd.normal({ ']c', bang = true })
  else
    gitsigns.nav_hunk('next')
  end
end

function M.toggle_blame()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win.winid)
    local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if filetype == "gitsigns-blame" then
      vim.api.nvim_win_close(win.winid, true)
      return
    end
  end
  vim.cmd("Gitsigns blame")
end

return M
