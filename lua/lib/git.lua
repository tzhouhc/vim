local M = {}

---check whether current file is under a git repo
---@return boolean
function M.is_git()
  -- remember: system calls return include a newline character
  local git = vim.fn.system("git rev-parse --is-inside-work-tree")
  return git:match("true") == "true"
end

---get the root of the current repo
---@return string
function M.git_repo_root()
  local match, _ = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n$", "")
  return match
end

return M
