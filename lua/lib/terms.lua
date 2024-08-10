local M = {}

function M.lazy_git()
  local ucf = ""
  if os.getenv("NERDFONT") == "2" then
    ucf = " -ucf=" .. os.getenv("XDG_CONFIG_HOME") .. "/lazygit/config_backup.yml"
  end
  vim.cmd(
    ":FloatermNew --height=0.9 --width=0.9 --wintype=float --title=lazygit --name=LazyGit --autoclose=2 lazygit" .. ucf
  )
end

-- This version of Yazi integration opens in a _split_. Yuck.
-- Using a plugin for this purpose instead.
function M.yazi()
  vim.cmd(":FloatermNew yazi")
end

function M.right_side_term()
  vim.cmd(":FloatermNew --height=0.9 --width=0.4 --position=right --title=Term --autoclose=2")
end

return M
