local win = require("lib.windows")
local misc = require("lib.misc")

local M = {}

function M.lazy_git()
  local ucf = ""
  if os.getenv("NERDFONT") == "2" then
    ucf = " -ucf=" .. os.getenv("XDG_CONFIG_HOME") .. "/lazygit/config_backup.yml"
  end
  vim.cmd(
    "FloatermNew --height=0.9 --width=0.9 --wintype=float --title=lazygit --name=LazyGit --autoclose=2 lazygit" .. ucf
  )
end

-- This version of Yazi integration opens in a _split_. Yuck.
-- Using a plugin for this purpose instead.
function M.yazi()
  vim.cmd("FloatermNew yazi")
end

function M.right_side_term()
  vim.cmd("FloatermNew --height=0.9 --width=0.4 --position=right --title=Term --autoclose=2")
end

---create a floaterm if none exists; toggle it otherwise.
function M.quake_term()
  if win.is_win_open_with_type("floaterm") then
    vim.cmd("FloatermToggle!")
    return
  end
  vim.cmd("FloatermNew --name=quake --height=0.4 --width=0.4 --position=topright --title=Term --autoclose=2")
end

function M.run_job_term()
  vim.ui.input({ prompt = "$ " }, function(input)
    if win.is_win_open_with_type("floaterm") then
      vim.cmd("FloatermSend " .. input)
      return
    end
    M.quake_term()
    vim.cmd("FloatermSend " .. input)
  end)
end

function M.git_lines_log()
  local start_line, end_line = misc.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  vim.cmd(
    "FloatermNew --height=0.9 --width=0.9 --wintype=float --title=logs --name=LineLogs --autoclose=2 git log -L" ..
    start_line .. "," .. end_line .. ":'" .. file .. "' | delta --paging=always"
  )
end

function M.git_lines_blame()
  local start_line, end_line = misc.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  vim.cmd(
    "FloatermNew --height=0.9 --width=0.9 --wintype=float --title=logs --name=LineLogs --autoclose=2 git blame -w -CCC -L" ..
    start_line .. "," .. end_line .. " '" .. file .. "' | delta --paging=always"
  )
end

return M
