local gitsigns = require("gitsigns")
local blame_ft = "gitsigns-blame"
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
  local wd = require("lib.windows")
  if wd.has_win_of_filetype(blame_ft) then
    wd.kill_all_win_of_filetype(blame_ft)
  else
    vim.cmd("Gitsigns blame")
  end
end

return M
