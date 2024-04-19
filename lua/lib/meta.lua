local M = {}

-- returned in place of normal plugins so that errors are silenced.
local NullSetup = {}
-- for the typical plugin's invocation of `setup(opts)`
function NullSetup.setup(...)
end
-- for telescope extensions
function NullSetup.load_extension(...)
end

-- protected call for loading plugins but not failing the entire script if
-- any individual thing should fail.
-- returns the module normally, or a NullSetup in case of failure. The NullSetup
-- object will run `setup` and `load_extension` functions with any params.
function M.safe_require(name)
  local req_func = function()
    return require(name)
  end
  local ok, res = xpcall(req_func, debug.traceback)
  -- local ok, module = pcall(require, name)
  if ok then
    return res
  else
    -- won't be silenced: this will invoke a hit-enter event
    print("Error loading module: "..name.."\n"..res)
  end
  return NullSetup
end

return M
