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

function M.yazi()
  vim.cmd(":FloatermNew yazi")
end

return M
