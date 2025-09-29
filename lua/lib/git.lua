-- Utilities for dealing with git repos from within vim -- checking repo status
-- and repo root.

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

---get the root of the current repo IF in a repo, otherwise return cwd.
---@return string
function M.soft_git_repo_root()
  if M.is_git() then
    return M.git_repo_root()
  else
    return vim.fn.getcwd()
  end
end

return M
