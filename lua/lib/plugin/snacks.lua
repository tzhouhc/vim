local edit = require("lib.editing")
local term = require("snacks.terminal")

local M = {}

local function term_with_cwd(cmd, opts)
  -- this *should* work normally; not sure what broke on snacks' end?
  local config = { cwd = vim.fn.getcwd() }
  if opts then
    config = vim.tbl_deep_extend("force", config, opts)
  end
  term.get(cmd, config)
end

local function toggle_term_with_cwd(cmd, opts)
  local config = { cwd = vim.fn.expand('%:p:h') }
  if opts then
    config = vim.tbl_deep_extend("force", config, opts)
  end
  term.toggle(cmd, config)
end

-- This version of Yazi integration opens in a _split_. Yuck.
-- Using a plugin for this purpose instead.
function M.yazi()
  term_with_cwd("yazi")
end

function M.lazygit()
  term_with_cwd("lazygit")
end

function M.right_side_term()
  term_with_cwd("zsh", { win = { style = "right_term" } })
end

---create a floaterm if none exists; toggle it otherwise.
function M.quake_term()
  toggle_term_with_cwd("zsh")
end

function M.git_lines_log()
  local start_line, end_line = edit.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  term.open(
    "git log -L" ..
    start_line .. "," .. end_line .. ":'" .. file .. "' | delta --paging=always",
    { cwd = vim.fn.expand('%:p:h') })
end

function M.git_lines_blame()
  local start_line, end_line = edit.get_visual_selection_lines()
  local file = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
  term.open(
    "git blame -w -CCC -L" ..
    start_line .. "," .. end_line .. " '" .. file .. "' | delta --paging=always",
    { cwd = vim.fn.expand('%:p:h') })
end

function M.repo_live_grep()
  if vim.fn.executable("local_live_grep_vim") == 1 then
    term_with_cwd("local_live_grep_vim")
  else
    vim.cmd("FzfLua live_grep")
  end
end

function M.global_file_list()
  if vim.fn.executable('seb') == 1 then
    term_with_cwd("seb_vim")
  end
end

function M.mods_chat()
  if vim.fn.executable('mods_chat') == 1 then
    term_with_cwd("mods_chat")
  end
end

return M
