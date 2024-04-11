local M = {}

function M.safe_require(name)
  local status, module = pcall(require, name)
  if status then
    return module
  else
    print("Error loading module: "..name)
  end
end

return M
