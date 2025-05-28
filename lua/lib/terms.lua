local edit = require("lib.editing")
local term = require("snacks.terminal")

local M = {}

-- This version of Yazi integration opens in a _split_. Yuck.
-- Using a plugin for this purpose instead.
function M.yazi()
  term.get("yazi")
end

function M.right_side_term()
  term.get("zsh", { win = { style = "right_term" } })
end

---create a floaterm if none exists; toggle it otherwise.
function M.quake_term()
  term.toggle("zsh")
end

function M.git_lines_log()
  local start_line, end_line = edit.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  term.open(
    "git log -L" ..
    start_line .. "," .. end_line .. ":'" .. file .. "' | delta --paging=always"
  )
end

function M.git_lines_blame()
  local start_line, end_line = edit.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  term.open(
    "git blame -w -CCC -L" ..
    start_line .. "," .. end_line .. " '" .. file .. "' | delta --paging=always"
  )
end

function M.repo_live_grep()
  if vim.fn.executable('local_live_grep_vim') == 1 then
    term.get("local_live_grep_vim")
  else
    vim.cmd("FzfLua live_grep")
  end
end

function M.global_file_list()
  if vim.fn.executable('seb') == 1 then
    term.get("seb_vim")
  end
end

return M
