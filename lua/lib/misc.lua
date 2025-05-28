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

return M
