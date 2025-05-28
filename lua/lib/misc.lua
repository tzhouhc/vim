-- Miscellaneous functions for general usage

-- WARN: do no include any plugin dependencies.

local M = {}

table.unpack = table.unpack or unpack

local sets = { { 97, 122 }, { 65, 90 }, { 48, 57 } } -- a-z, A-Z, 0-9

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

local function last_non_empty_line(row)
  if row == nil then
    row = vim.api.nvim_win_get_cursor(0)[1] - 1
  end
  local content = ""
  repeat
    content = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    row = row - 1
  until (content ~= "" or row == 0)
  return content
end

---get the character under the cursor with the given offset
---@param offset integer
---@param lookback boolean
function M.get_char_at_cursor(offset, lookback)
  if offset == nil then
    offset = 0
  end
  if lookback == nil then
    lookback = false
  end
  local line = vim.api.nvim_get_current_line()
  local pos = vim.api.nvim_win_get_cursor(0)[2] + offset + 1
  if pos <= 0 then
    if lookback then
      local line = last_non_empty_line()
      if line ~= nil then
        return line:sub(#line, #line)
      end
    else
      pos = 0
    end
  end
  return line:sub(pos, pos)
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

--- generate a random string
---@param chars integer
local function random_str(chars)
  local str = ""
  for i = 1, chars do
    math.randomseed(os.clock() ^ 5)
    local charset = sets[math.random(1, #sets)]
    str = str .. string.char(math.random(charset[1], charset[2]))
  end
  return str
end

--- create a temp file with filename.
function M.make_scratch()
  local name = random_str(8)
  vim.cmd("e /tmp/vim-scratch-" .. name)
end

-- Function to get start and end lines of visual selection
function M.get_visual_selection_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- start_pos[2] and end_pos[2] contain the line numbers
  local start_line = start_pos[2]
  local end_line = end_pos[2]

  return start_line, end_line
end

return M
