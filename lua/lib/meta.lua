local M = {}

-- toggle on whether to display load time stack trace if load failed.
M.debug = true

-- returned in place of normal plugins so that errors are silenced.
local NullSetup = {}
-- for the typical plugin's invocation of `setup(opts)`
function NullSetup.setup(...) end

-- for telescope extensions
function NullSetup.load_extension(...) end

-- for luasnip extensions
function NullSetup.lazy_load(...) end

--- protected call for loading plugins but not failing the entire script if
--- any individual thing should fail.
--- returns the module normally, or a NullSetup in case of failure. The NullSetup
--- object will run `setup` and `load_extension` functions with any params.
---@param name string the name of the module being loaded.
function M.safe_require(name)
  local ok, res = pcall(require, name)
  if not ok then
    if M.debug then
      print("Error loading module: " .. name .. "\n" .. res)
    else
      print("Error loading module: " .. name)
    end
    return NullSetup
  end
  return res
end

return M
