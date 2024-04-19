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
  local status, module = pcall(require, name)
  if status then
    return module
  else
    print("Error loading module: "..name)
    return NullSetup
  end
end

return M
