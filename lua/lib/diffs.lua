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

return M
