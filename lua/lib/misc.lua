local safe_require = require('lib.meta').safe_require

local M = {}

local function extract_plugin(line)
  return line:match("[\"'](.+/[^'\"]+)[\"']")
end

function M.popup(content)
  -- require("noice").redirect(function()
  --   print(content)
  -- end, { view = "cmdline_popup" })
  require("noice").notify(content, 0)
end

function M.get_current_line_plugin()
  local line = vim.api.nvim_get_current_line()
  local plugin = extract_plugin(line)
  M.popup("https://github.com/"..plugin)
end

return M
