local misc = require("lib.misc")
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
  local start_line, end_line = misc.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  term.open(
    "git log -L" ..
    start_line .. "," .. end_line .. ":'" .. file .. "' | delta --paging=always"
  )
end

function M.git_lines_blame()
  local start_line, end_line = misc.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  term.open(
    "git blame -w -CCC -L" ..
    start_line .. "," .. end_line .. " '" .. file .. "' | delta --paging=always"
  )
end

return M
