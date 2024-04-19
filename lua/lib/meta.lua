local M = {}

-- returned in place of normal plugins so that errors are silenced.
local NullSetup = {}
-- for the typical plugin's invocation of `setup(opts)`
function NullSetup.setup(...)
end
-- for telescope extensions
function NullSetup.load_extension(...)
end

function M.safe_require(name)
  local ok, module = pcall(require, name)
  if ok then
    return module
  else
    print("Error loading module: "..name)
  end
  return NullSetup
end

return M
