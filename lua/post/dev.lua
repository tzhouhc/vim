local misc = require("lib.misc")

_G.dump = function(o)
  vim.notify("\n" .. misc.dump(o), vim.log.levels.DEBUG)
end

vim.api.nvim_create_user_command("ExecuteSelected", function(opts)
  -- Only proceed if current filetype is Lua
  if vim.bo.filetype ~= "lua" then return end

  -- Get visual selection range
  local line1 = opts.line1
  local line2 = opts.line2
  if not (line1 and line2) then return end

  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  local code = table.concat(lines, "\n")

  local f, err = load(code)
  if not f then
    vim.notify("ExecuteSelected: Load error: " .. tostring(err), vim.log.levels.ERROR)
    return
  end

  local ok, exec_err = pcall(f)
  if not ok then
    vim.notify("ExecuteSelected: Runtime error: " .. tostring(exec_err), vim.log.levels.ERROR)
  end
end, { range = true, desc = "Execute visually selected Lua code" })

