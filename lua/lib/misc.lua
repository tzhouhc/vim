-- Miscellaneous functions for general usage

-- WARN: do no include any plugin dependencies.

local M = {}

local function extract_plugin(line)
  -- first string literal in the line
  return line:match("[\"']([^'\"]+)[\"']")
end

function M.dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

---Setup autocmd to close a window on cursor move. Suitable for use with
---nvim.notify.
---@param win integer
function M.window_auto_close(win)
  vim.api.nvim_create_autocmd({ "CursorMoved" }, {
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
    once = true,
  })
end

---look for patterns matching a GitHub repo and open it in the browser.
function M.get_current_line_plugin()
  local line = vim.api.nvim_get_current_line()
  local plugin = extract_plugin(line)
  if vim.fn.has("macunix") then
    -- directly shell out and open the plugin github page
    vim.fn.system("open 'https://github.com/" .. plugin .. "'")
  else
    -- create popup with the link so user can do whatever
    M.popup("https://github.com/" .. plugin)
  end
end

---check for windows with specific key properties, e.g. "quickfix"
---@param type string
---@return boolean
function M.has_win_of_type(type)
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win[type] == 1 then
      return true
    end
  end
  return false
end

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

---Batch set mappings. Expects a table where the top level are tables keyed by
---modes, and tables contain lhs string keys to rhs string or function values.
---@param mappings table
function M.batch_set_keymap(mappings)
  for mode, conf in pairs(mappings) do
    for key, val in pairs(conf) do
      if type(val) == "string" or type(val) == "function" then
        -- default configuration
        vim.keymap.set(mode, key, val, { noremap = true, silent = true })
      else
        local command, opts = unpack(val)
        vim.keymap.set(mode, key, command, opts)
      end
    end
  end
end

return M
