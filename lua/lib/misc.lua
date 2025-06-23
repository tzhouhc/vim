-- Miscellaneous functions for general usage

-- WARN: do no include any plugin dependencies.

local M = {}

table.unpack = table.unpack or unpack

local sets = { { 97, 122 }, { 65, 90 }, { 48, 57 } } -- a-z, A-Z, 0-9

local function extract_plugin(line)
  -- first string literal in the line
  return line:match("[\"']([^'\"]+)[\"']")
end

local function make_indent(level)
  return string.rep("  ", level)
end

local function _dump(o, indent)
  indent = indent or 0

  if type(o) == "table" then
    local s = "{\n"
    for k, v in pairs(o) do
      local key
      if type(k) ~= "number" then
        key = '"' .. k .. '"'
      else
        key = k
      end
      s = s .. make_indent(indent + 1) .. "[" .. key .. "] = " .. _dump(v, indent + 1) .. ",\n"
    end
    s = s .. make_indent(indent) .. "}"
    return s
  else
    return tostring(o)
  end
end

function M.dump(o)
  return _dump(o, 0)
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
    vim.notify("https://github.com/" .. plugin, vim.log.levels.INFO)
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

-- unused -- function to create a lookup
local function show_dictionary_popup(word)
  -- Run the shell command asynchronously
  vim.fn.jobstart({ 'dictionary', word }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        -- Remove empty lines at the end
        while #data > 0 and data[#data]:match('^%s*$') do
          table.remove(data)
        end
        if #data == 0 then data = { 'No results.' } end
        vim.schedule(function()
          vim.lsp.util.open_floating_preview(
            data, 'markdown', { border = 'single', focusable = false, close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' }, }
          )
        end)
      end
    end
  })
end

return M
